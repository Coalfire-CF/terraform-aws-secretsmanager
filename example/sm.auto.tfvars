is_gov        = true           # Update to false if not in AWS GovCloud
aws_region    = ""             # Input AWS Region
profile       = ""             # Input profile name
kms_key_id    = ""             # Pull KMS Key ID from AWS Console
path          = "production/"  # Input desired path. Typically includes application name
tags          = { Environment = "test1" }
regional_tags = { Environment = "test2" }
