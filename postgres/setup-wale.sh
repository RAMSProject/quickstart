#!/bin/bash

if [ "$AWS_ACCESS_KEY_ID" = "" ]
then
    echo "AWS_ACCESS_KEY_ID does not exist"
else
    if [ "$AWS_SECRET_ACCESS_KEY" = "" ]
    then
        echo "AWS_SECRET_ACCESS_KEY does not exist"
    else
        if [ "$WALE_S3_PREFIX" = "" ]
        then
            echo "WALE_S3_PREFIX does not exist"
        else
            echo "Scheduling WAL backups";
            echo "wal_level = hot_standby" >> /var/lib/postgresql/data/postgresql.conf
            echo "archive_mode = on" >> /var/lib/postgresql/data/postgresql.conf
            echo "archive_command = 'envdir /etc/wal-e.d/env /venv/bin/wal-e wal-push %p'" >> /var/lib/postgresql/data/postgresql.conf
            echo "archive_timeout = 60" >> /var/lib/postgresql/data/postgresql.conf

            # Assumption: the group is trusted to read secret information
            umask u=rwx,g=rx,o=
            mkdir -p /etc/wal-e.d/env

            echo "$AWS_SECRET_ACCESS_KEY" > /etc/wal-e.d/env/AWS_SECRET_ACCESS_KEY
            echo "$AWS_ACCESS_KEY_ID" > /etc/wal-e.d/env/AWS_ACCESS_KEY_ID
            echo "$WALE_S3_PREFIX" > /etc/wal-e.d/env/WALE_S3_PREFIX
            chown -R root:postgres /etc/wal-e.d

            echo "Fetching latest backups";

            # $PGDATA cannot be removed so use temporary dir
            # If you don't stop the server first, you'll waste 5hrs debugging why your WALs aren't pulled
            if su - postgres -c "envdir /etc/wal-e.d/env /venv/bin/wal-e backup-fetch /tmp/pg-data LATEST"; then
              echo "Backup fetched, restoring from backup"
              gosu postgres pg_ctl -D "$PGDATA" -w stop
              su - postgres -c "cp -rf /tmp/pg-data/* $PGDATA"
              su - postgres -c "rm -rf /tmp/pg-data"

              # Create recovery.conf
              echo "standby_mode     = 'off'" >> $PGDATA/recovery.conf
              echo "primary_conninfo = 'user=$POSTGRES_USER password=$POSTGRES_PASSWORD'" >> $PGDATA/recovery.conf
              echo "restore_command  = 'envdir /etc/wal-e.d/env /venv/bin/wal-e wal-fetch "%f" "%p"'" >> $PGDATA/recovery.conf

              cat $PGDATA/recovery.conf
              chown -R postgres "$PGDATA"

              # Starting server again to satisfy init script
              gosu postgres pg_ctl -D "$PGDATA" -o "-c listen_addresses=''" -w start
            else
              echo "Backup not found. Continuing with empty database."
              gosu postgres pg_ctl -D "$PGDATA" -w stop
              gosu postgres pg_ctl -D "$PGDATA" -o "-c listen_addresses=''" -w start
              su - postgres -c "/usr/bin/envdir /etc/wal-e.d/env /venv/bin/wal-e backup-push /var/lib/postgresql/data"
            fi

            su - postgres -c "crontab -l | { cat; echo \"0 3 * * * /usr/bin/envdir /etc/wal-e.d/env /venv/bin/wal-e backup-push /var/lib/postgresql/data\"; } | crontab -"
            su - postgres -c "crontab -l | { cat; echo \"0 4 * * * /usr/bin/envdir /etc/wal-e.d/env /venv/bin/wal-e delete --confirm retain 7\"; } | crontab -"
        fi
    fi
fi
