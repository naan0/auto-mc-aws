# auto-mc-aws
This is a system which can connect to any AWS account (when configured properly) and auto-provision an FTB or other curseforge modded minecraft server using spot instances.

# Features
1. (TBD) auto healing - when the spot price spikes, we automatically save the world and bring up a new one in an AZ that is more stable
2. (TBD) uses spot instances, very cheap
3. (TBD) configurable - use any instance type, region/az, etc
4. uses docker and can be pointed at any modpack/world/config to bootstrap

# Getting started
Your world is going to live on an EBS volume, but will be backed by s3 (backups go there, init starts from there)

In addition to the world itself, the following files can be managed by auto-mc-aws:

  server.properties
  banned-ips.json
  banned-players.json
  ops.json
  server-icon.png
  whitelist.json

These files should be placed inside the world's directory, in a folder called auto-mc-aws. auto-mc-aws will create symlinks from the server root to this directory in the world folder.

---
Documenting current state:

CloudFormation manually setup to launch ECS cluster
Manually created ECS service definition for modpack specific minecraft instanecs
Manually run ECS service per each modpack

TODO: templatize the CloudFormation and ECS definitions so it all can be run from cmd line
