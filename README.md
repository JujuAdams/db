<p align="center"><img src="https://raw.githubusercontent.com/JujuAdams/db/master/LOGO.png" style="display:block; margin:auto; width:300px"></p>
<h1 align="center">db 1.0.0</h1>

<p align="center">Prototype savedata database system for GameMaker LTS 2022</p>

&nbsp;

&nbsp;

- ### Got questions? [Make a new issue!](https://github.com/JujuAdams/db/issues/new)
- ### There is also a [Discord server](https://discord.gg/hwgWpnsNw2) (but GitHub issues are preferred)
- ### [Download the .yymps](https://github.com/JujuAdams/db/releases/)

&nbsp;

## Saving And Loading Databases

db contains two debug functions that can be used to easily save databases to disk - `db_debug_save()` and `db_debug_load()`. As the names suggest, these are intended only for debug use. You should not use these functions in production.

Instead, you should save and load buffers asynchronously for proper game builds. You can use GameMaker's [native async buffer functions](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Buffers/buffer_save_async.htm) and db is compatible with existing save/load systems that use GameMaker's async buffer functions. Alternatively, you can use another library that I've made called [Sparkle Store](https://github.com/jujuadams/Sparkle-Store) that wraps around the native GameMaker functions and gives you a more friendly API to use.

### Native Functions

GameMaker's native asynchronous buffer functions require that you use the "Async - Save/Load" event to handle results. The example below is the bare minimum and on console you'll need to modify the code below to meet platform certification requirements.

#### Saving:

```gml
/// Save Function

var _buffer = db_buffer_create(database);
buffer_async_group_begin("default");
buffer_save_async(_buffer, "filename.json", 0, buffer_get_size(_buffer));
saveID = buffer_async_group_end();
buffer_delete(_buffer); //We can delete the buffer straight away



/// Async - Save/Load Event

var _id     = async_load[? "id"    ];
var _status = async_load[? "status"];

if (saveID == _id)
{
    if (_status)
    {
    	//File saved successfully
    }
    else
    {
    	//File failed to save
    }
}
```

#### Loading:

```gml
/// Load Function

loadBuffer = buffer_create(1, buffer_grow, 1);
buffer_async_group_begin("default");
buffer_load_async(loadBuffer, "filename.json", 0, -1);
loadID = buffer_async_group_end();



/// Async - Save/Load Event

var _id     = async_load[? "id"    ];
var _status = async_load[? "status"];

if (loadID == _id)
{
	//Decode the saved data
    var _loadedDatabase = _status? db_buffer_read(loadBuffer) : undefined;
    
    //Clean up
    buffer_delete(loadBuffer);
	loadID = undefined;
    loadBuffer = undefined;
    
    if (_loadedDatabase != undefined)
    {
    	database = _loadedDatabase;
    	//File loaded successfully
    }
    else
    {
    	//File failed to load
    }
}
```

### Sparkle Store

Sparkle Store uses callback functions. Please see [documentation](https://github.com/jujuadams/Sparkle-Store) for more information. Sparkle Store also has a handful config macros and functions that you can use to set up properly for console.

#### Saving:

```gml
/// Save Function

var _buffer = db_buffer_create(database);
SparkleSave("filename.json", _buffer, function(_status, _buffer)
{
    //Clean up
    buffer_delete(_buffer);
    
    if (_status)
    {
    	//File saved successfully
    }
    else
    {
    	//File failed to save
    }
});
```

#### Loading:

```gml
/// Load Function

SparkleLoad("filename.json", _buffer, function(_status, _buffer)
{
    var _loadedDatabase = _status? db_buffer_read(_buffer) : undefined;

    //Clean up
    buffer_delete(_buffer);

    if (_loadedDatabase != undefined)
    {
    	database = _loadedDatabase;
    	//File loaded successfully
    }
    else
    {
    	//File failed to load
    }
});
```