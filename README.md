<h1 align="center">db</h1>

<p align="center">Prototype savedata database system for GameMaker LTS 2022 by <b>@jujuadams</b></p>

<p align="center">Chat about db on the <a href="https://discord.gg/8krYCqr">Discord server</a></p>

&nbsp;

`db_create()`

`db_duplicate(database)`

`is_db(value)`

`db_has_data(database)`

`db_write(database, value, key, ...)`

`db_read(database, default, key, ...)`

`db_delete(database, key, ...)`

`db_exists(database, key, ...)`

`db_clear(database)`

`db_save(database, database, [pretty=false])`

`db_load(filename)`

`db_buffer_write(buffer, database, [pretty=false])`

`db_buffer_read(buffer)`

`db_set_raw_data(database, data)`

`db_get_raw_data(database)`

`db_set_metadata(database, metadata)`

`db_get_metadata(database)`

`db_set_changed(database, state)`

`db_get_changed(database, [resetState=true])`

`db_set_timestamp(database, timestamp)`

`db_get_timestamp(database)`

`db_most_recent(arrayOfDatabases, [returnIndex=false])`

`db_sort_by_timestamp(arrayOfDatabases, mostRecent)`
