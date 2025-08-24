docker run -d --name oracle \
  -p 1521:1521 -p 5500:5500 \
  -e ORACLE_PWD=672005 \
  -v oracle_data:/opt/oracle/oradata \
  oracle/database:19.3.0-ee
