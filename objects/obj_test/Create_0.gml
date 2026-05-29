show_debug_message("=== basic setter ===");
db = db_create();
db_write(db, 10,   "test", 0, "test 2");
db_write(db, object_index,   "test obj reference");
db_debug_save(db, "a.json");



show_debug_message("");
show_debug_message("=== basic loader ===");
db = db_debug_load("a.json");
show_debug_message(db_read(db, "test", 0, "test 2") ?? "!");
show_debug_message(object_get_name(handle_parse(db_read(db, "test obj reference"))));



show_debug_message("");
show_debug_message("=== db_add() ===");
db = db_create();
db_add(db, 3);
show_debug_message(db_read(db));
db_write(db, {
    a: 0,
    b: 1,
});
db_add(db, 0.1, "a");
db_add(db, 0.2, "b");
show_debug_message(db_read(db, "a"));
show_debug_message(db_read(db, "b"));



show_debug_message("");
show_debug_message("=== debug string and patching ===");
db = db_create();
db_write(db, { a: 0 }, "test");
db_write(db, 1, "test", "a");
db_write(db, 2, "test", "b");
db_patch(db, { c: [3, 3] }, "test");
show_debug_message(db_get_debug_string(db));
show_debug_message("");
db_patch(db, [pointer_null, 10], "test", "c");
show_debug_message(db_get_debug_string(db));
show_debug_message("");



show_debug_message("");
show_debug_message("=== debug string again ===");
db_d = db_create();
db_write(db_d, 1, "a");
db_write(db_d, 2, "b");
db_write(db_d, 3, "c", "d");
show_debug_message(db_get_debug_string(db_d));



show_debug_message("");
show_debug_message("=== defaults ===");
db_e = db_create({
    structs: {
        a: 1,
        c: 3,
    },
    templates: {
        a: {
            first: 3.141,
        },
    },
},
{
    structs: {
        a: 1,
        b: 2,
        c: 3,
    },
    defaults: {
        no_default: {
            first: 10,
            second: 20,
        },
        _CATCH_: {
            first: 1,
            second: 2,
        },
    },
    arrays: [
        "array default",
    ],
    arrays_with_nesting: [
        {
            _CATCH_: "template value",
        },
    ],
});

show_debug_message(db_read_then_default(db_e, "structs", "a"));
show_debug_message(db_read_then_default(db_e, "structs", "b"));
show_debug_message(db_read_then_default(db_e, "structs", "c"));
show_debug_message(db_read_then_default(db_e, "defaults", "no_default", "first"));
show_debug_message(db_read_then_default(db_e, "defaults", "a", "first"));
show_debug_message(db_read_then_default(db_e, "defaults", "b", "second"));
show_debug_message(db_read_then_default(db_e, "arrays", 42));
show_debug_message(db_read_then_default(db_e, "arrays_with_nesting", 7, "a"));
show_debug_message(db_read_then_default(db_e, "arrays_with_nesting", 7, "b"));