job "mailman" {
	datacenters = ["dc1"]

	group "mailman-3" {
		count = 1
		task "core" {
			driver = "docker"

			config {
				image = "maxking/mailman-core:rolling"	

				volumes = [
					"/opt/mailman/core:/opt/mailman/"
				]
			}
		
			env {
		     		"DATABASE_URL"       = "postgres://mailman:mailmanpass@database/mailmandb"
		     		"DATABASE_TYPE"      = "postgres"
		     		"DATABASE_CLASS"     = "mailman.database.postgresql.PostgreSQLDatabase"
		     		"HYPERKITTY_API_KEY" = "someapikey"
			}
		}
		
		task "web" {
			driver = "docker"
			
			config {
				image = "maxking/mailman-web:rolling"

				volumes = [
					# get it to common place
					"/opt/mailman/web:/opt/mailman-web-data"
				]
			}

				env {
					"DATABASE_TYPE" = "postgres"
    			"DATABASE_URL" = "postgres://mailman:mailmanpass@database/mailmandb"
    			"HYPERKITTY_API_KEY" = "someapikey"
				}	
		}
	}
}
