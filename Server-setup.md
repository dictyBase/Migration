# Type of hosting
## Shared hosting: 
* Sharing one VM with others.

# Cloud style hosting
* IAAS, PAAS, SAAS style.
* Server hardwares are abstarcted, user has knowledge about it.
* Provides command line/Web interface for adding hardware and services.
* The best for dictyBase.

# VPS style hosting
* Dedicated VM, however shares with other VM in the server.

# Dedicated hosting
* Our own server(metal or VM), no physical sharing.

# Colocated hosting
* Our own server(metal or VM), no physical sharing.
* We buy and manage hardware.

# Hybrid hosting
Cloud style with colocated ? Is it possible ? openstack ?
Any other possiblity ?


# Server hardware configurations

## Production
## Application server
* 8 cores
* 8 GB RAM
* ~2 TB storage to start with

## Postgresql database server
* 16 cores 
* 32 GB RAM
* ~ 2 - 3 TB usable storage

## Staging
Half of the requirement compared to prod, probably don't need that much of storage ?

## Discussions/Questions
* Do we need to buy new servers ?
* Could dictybase manage additions of CPU and memory ?
* Could dictybase get pool of hard drive space and manage them as required ?
* If the above not true, how do we add hard drive space ?
* How a complete server failure is managed ?
* Could dictyBase chosse its own postgresql layout ?
* Do we need a separate database backup server for offsite data storage ? If so what configuration ?

## Logging/Monitoring server
* Is there something exist in NUBIC we could use ?
    What stack ? How do we use them ?
* If not do we need a separate server ? What configuration ?

# Hard disk space issue
## Production
What's been done ?

## Blast server
What's been done ?
