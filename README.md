<p align="center"><img src="https://raw.githubusercontent.com/JujuAdams/db/master/LOGO.png" style="display:block; margin:auto; width:300px"></p>
<h1 align="center">db 2.1.0</h1>

<p align="center">Savedata database system for GameMaker 2024.14</p>

&nbsp;

&nbsp;

- ### Got questions? [Make a new issue!](https://github.com/JujuAdams/db/issues/new)
- ### There is also a [Discord server](https://discord.gg/hwgWpnsNw2) (but GitHub issues are preferred)
- ### [Download the .yymps](https://github.com/JujuAdams/db/releases/)

&nbsp;

## What is db?

At its simplest, db is a set of helper functions that wrap around GameMaker's struct and array features to make them easier to use for savedata. In this sense, db is a library for conveniently manipulating JSON. I have found in my commercial work that the same problems need to be solved again and again and JSON is often the right tool for the job. What tends to get in the way is making JSON accessible and db goes some way to solve this problem.

It's worth pointing out here that this discussion of db is going to presume familiarity with JSON, GameMaker's struct and array features, and general ideas of good practice in GameMaker development. I think db is easy to use but it's not a tool for the complete beginner.

db is centred around the concept of "lazy access". This is pretty much what it sounds like: instead of doing lots of error handling, db will instead do its best to always read and write values with crashing. For programmers familiar with C#'s null-conditional operator (`a?.b` `a?[b]`), db is that plus some extra bells and whistles. You can forget about strict access rules and instead write code that communicates what you want to happen rather than the precise steps needed to get there. This means db relies on a lot of implicit behaviour but it's implicit behaviour that is predictable and helpful. db is a small step towards [declarative programming](https://en.wikipedia.org/wiki/Declarative_programming) which I think is neat.

The following example shows nested struct access and how db can help make code both safer and friendlier to write. Please note that db works just as well with arrays and structs combined even if the example doesn't contain any arrays. Anyway, consider the following JSON structure:

```gml
global.data = {
    "settings": {
        "audio": {
            "music": 1,
            "sfx": 1,
        },
    ]
}
```

If we want to read the volume to play music at we'd read `global.data.settings.audio.music`. We're telling the program that we want to read exactly that value stored deep inside a JSON tree by accessing a sequence of structs. If the program can't find any one of those structs then the program will "throw an exception" a.k.a. crash. Reading information from a bunch of nested structs like this is a brittle operation - if one part of the chain snaps then the whole chain fails. For settings data specifically this sort of problem could happen in multiple ways: you forgot to initialize empty savedata correctly when starting a new game, you added a new settings option and the player is migrating old savedata that is missing the new setting, you made a typo in the command, there has been data corruption, etc.  Nothing will frustrate your players more than broken savedata and rightly so.

What we need is a more robust way of accessing data such that if some part of the data is missing then the game is able to recover or at least fall back on good default behaviour. If we were going to do this in native GML it would look like this:

```gml
function GetMusicVolume()
{
    var _value = global.savedata[$ "settings"];
    if (is_struct(_value))
    {
        _value = _value[$ "audio"];
        if (is_struct(_value))
        {
            _value = _value[$ "music"];
        }
    }
    
    if (not is_numeric(_value))
    {
        //Fall back on a helpful value if we fail
        _value = 1;
    }
    
    return _value;
}
```

Not pretty code. All of the extra error checking makes this much harder to read than the elegant-but-fragile code we had before. It does the job but it leaves much to be desired. Here's how you do it in using db:

```gml
function GetMusicVolume()
{
    return db_read(global.database, 1, "settings", "audio", "music");
}
```

A substantial improvement. db can accomplish in a single line what takes native GML a dozen lines.

The situation is similar for writing data too. Writing data in a "lazy" way means we need to step along the tree, checking at each stage if we need to create a new struct to fill in a gap:

```gml
function SetMusicVolume(_value)
{
    var _struct = global.savedata;
    
    var _struct = _struct[$ "settings"];
    if (not is_struct(_value))
    {
        _struct.settings = {};
        _struct = _struct.settings;
    }
    
    var _struct = _struct[$ "audio"];
    if (not is_struct(_value))
    {
        _struct.audio = {};
        _struct = _struct.audio;
    }
    
    _struct.music = _value;
}
```

Again, verbose and clumsy. This is one line of code when using db:

```gml
function SetMusicVolume(_value)
{
    return db_write(global.database, _value, "settings", "audio", "music");
}
```

db has further functions that operate on JSON data along the "lazy access" principle. Additionally, db has features catering to the specific needs of savedata including metadata and timestamps.

&nbsp;

## What does db not do?

db isn't going to fix bugs for you or answer architectural questions. If you need big binary blobs or can't use JSON for savedata (such as for data with circular references) then db will be of no use. db is also not going to work well if you're prone to lots of typos. One of the sacrifices we make as developers is the trade-off between safety and flexibility. Generally speaking, the more flexible the system the easier it is to make mistakes. This is certainly the case for db where a typo will manifest as data being saved where it shouldn't be or default values being returned unexpectedly.

db also doesn't natively handle the actual action of saving and loading to a device's storage. db gives structure to your data and tools to get at that data but it stops short of being a comprehensive file access system. It'd be far too much complexity for one library to cover everything without being overwhelming. File access is a surprisingly tricky subject and [other libraries](https://github.com/jujuadams/SparkleStore) should be used for the file operations themselves. That having been said, there are two debug save/load functions for quick testing. Further on in this guide you'll find some advice on saving and loading files in a way that ensures you're not left high and dry when trying to port your game to console.

&nbsp;

## What is a db database?

Observant readers will have noticed that the db usage examples above swapped out `global.savedata` for a mysterious `global.database`. db has a special concept of a "database". Databases must always function as the root element for a db-compatible JSON tree. Where normally you might have a struct or an array as the root node, db requires its own data structure. This is a practical requirement owing to db's additional metadata features, change tracking, and further adds extra safety.

You must create a database using `db_create()`. This will return a new empty database. You can then use this database for other db functions much like you would use a normal root node. A db database is a struct, specifically a struct generated by the internal `__db_class` constructor. This struct contains no public variables nor does it contain public methods. To use this database you **must** use db functions.

One of the most helpful features of a database is that it will track whether values inside the database have been changed by db functions (`db_write()`, `db_delete()` etc.). You can then call `db_get_changed()` to detect if a database has changed and, if so, then execute some code to save the database to storage. This saves having to write code that checks for changes in every single place that a value might changes. Instead, you can bundle together changes and save only when you need to.

This change state, along with metadata and a timestamp, is stored inside the root database node. Because it is a special data structure, you should not save a database using standard GameMaker functions (such as `json_stringify()`). db has three dedicated functions to handle converting databases to and from binary data. These are `db_buffer_create()`, `db_buffer_write()`, and `db_buffer_read()`.

&nbsp;

## Saving and loading databases

db contains two debug functions that can be used to easily save databases to disk - `db_debug_save()` and `db_debug_load()`. As the names suggest, these are intended only for debug use. You should not use these functions in production.

You should save and load buffers asynchronously for proper game builds. You can use GameMaker's [native async buffer functions](https://manual.gamemaker.io/lts/en/GameMaker_Language/GML_Reference/Buffers/buffer_save_async.htm) and db is compatible with existing save/load systems that use GameMaker's async buffer functions. Alternatively, you can use another library that I've made called [SparkleStore](https://github.com/jujuadams/SparkleStore) that wraps around the native GameMaker functions and gives you a more friendly API to use.

### Native functions

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

### SparkleStore

SparkleStore uses callback functions. Please see [documentation](https://github.com/jujuadams/SparkleStore) for more information. SparkleStore also has a handful config macros and functions that you can use to set up properly for console.

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
