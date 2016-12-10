# Rocket Chat in Docker

Simple script that starts a Rocket Chat server by performing all the requisite steps:
1. Pull the latest images
1. Create a persistent data container
1. Run a db container with volumes from the data container
1. Run a rocket.chat container that links to the db

That way the script can just be run again to update without losing data.

