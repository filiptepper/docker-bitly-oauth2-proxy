# bitly/oauth2_proxy Dockerfile

Pass all CLI options to Docker's `run` command, eg.:

```bash
docker run --rm \
  --name=oauth2-proxy \
  --network=my-network \
  --publish=4180:4180 \
  filiptepper/bitly-oauth2-proxy:latest \
  --cookie-secret=my-cookie-secret \
  --client-id=my-client-id \
  --client-secret=my-client-secret \
  --http-address=0.0.0.0:4180 \
  --upstream=http://application:81
```

This also works for `docker-compose`, eg.:

```yaml
version: '3.4'

services:
  proxy:
    image: filiptepper/bitly-oauth2-proxy
    depends_on:
      - application
    command: --cookie-secret=my-cookie-secret --client-id=my-client-id --client-secret=my-client-secret --http-address=0.0.0.0:4180 --upstream=http://application:81
    ports:
      - 4180:4180
```
