## Installation

1. [Install Docker](https://download.docker.com/mac/stable/Docker.dmg)
2. [Install Terraform](https://www.terraform.io/downloads.html)
3. Bring up docker containers
```bash
make up
```
4. Run a migration
```
make migrate
```
5. Add a scheduler
```
make schedule
```
6. Start monitoring
```
make create URL=http://example.com
```
7. Check domain status
```
make list or make ls
```


