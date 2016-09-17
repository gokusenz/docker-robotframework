# docker-robotframework

Build image
```
docker build -t docker-robotframework .
```

Run in container with FILE
```
docker run --rm -e TEST_FILE=firefox.txt \
-v $(pwd)/robots:/robots \
-ti docker-robotframework
```

Run in container with PATH
```
docker run --rm -e TEST_PATH=/robots/ \
-v $(pwd)/robots:/robots \
-ti docker-robotframework
```