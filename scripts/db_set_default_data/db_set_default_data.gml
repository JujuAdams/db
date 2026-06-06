// Feather disable all

/// Sets the default data template for a database, overwriting whatever default data was previously
/// set. This function will not set the "changed" state of the database. Default values that you
/// set with this function can be returned by `db_default()` and `db_read_then_default()`.
/// 
/// The default data template should follow the same structure as the data you're reading and
/// writing i.e. nested structs and arrays.
/// 
///     database = db_create(); //Empty database
///     db_set_default_data(database,
///     {
///         audio: {
///             music: 1,
///             sfx: 0.9,
///         },
///     });
///     
///     db_read_then_default(db, "audio", "music");    // = 1
///     db_read_then_default(db, "audio", "sfx");      // = 0.9
///     db_exists(database, "audio", "sfx");           // = false
///     db_write(database, 0.5,   "audio", "sfx");
///     db_exists(database, "audio", "sfx");           // = true
///     db_read_then_default(db, "audio", "sfx");      // = 0.5 (because we set a value)
///     db_read_then_default(db, "audio", "ambience"); //error! missing value + no default value
/// 
/// Arrays data is presumed to be homogenous. This is a fancy way of saying that there should be no
/// difference in default values between members of an array. You only need to define one element
/// in an array and that element's default values will be duplicated.
/// 
///     database = db_create(); //Empty database
///     db_set_default_data(database,
///     {
///         array: [
///             {
///                 data: 42
///             }
///         ]
///     });
///     
///     db_read_then_default(database, "array", 0, "data"); // = 42
///     db_read_then_default(database, "array", 1, "data"); // = 42
///     db_read_with_default(database, "array", 2, "data"); // = 42
///     //etc.
/// 
/// 
/// The variable name `_CATCH_` may be used as a fallback variable name for structs. This fallback
/// value will be used if a variable name in a struct cannot be found. This if helpful for structs
/// that are being used as dictionaries.
/// 
///     database = db_create(); //Empty database
///     db_set_default_data(database,
///     {
///         alice: "primose",
///         bob: "tulip",
///         _CATCH_: "jasmine"
///     });
///     
///     db_read_then_default(database, "alice");   // = "primose"
///     db_read_then_default(database, "bob");     // = "tulip"
///     db_read_then_default(database, "charlie"); // = "jasmine"
///     db_read_then_default(database, "daisy");   // = "jasmine"
/// 
/// @param database
/// @param defaultData

function db_set_default_data(_database, _defaultData)
{
    _database.__defaultData = _defaultData;
}
