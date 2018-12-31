# auto-mc-aws
This is a system which can connect to any AWS account (when configured properly) and auto-provision an FTB or other curseforge modded minecraft server using spot instances.

# Features
1. auto healing - when the spot price spikes, we automatically save the world and bring up a new one in an AZ that is more stable
2. uses spot instances, very cheap
3. configurable - use any instance type, region/az, etc

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
