## Installation

1. [Install docker](https://download.docker.com/mac/stable/Docker.dmg)
2. Bring up docker containers
```bash
make up
```
3. Run a migration
```
make migrate
```
4. Add a scheduler
```
make schedule
```
5. Start monitoring
```
make create URL=http://example.com
```
6. Check domain status
```
make list or make ls
```


