show_debug_message("");

db_a = db_create();
db_write(db_a, 10, "test", 0, "test 2");
db_write(db_a, object_index, "test obj reference");
db_debug_save(db_a, "a.json");

db_b = db_debug_load("a.json");
show_debug_message("=== db_b ===");
show_debug_message(db_read(db_b, "test", 0, "test 2") ?? 0);
show_debug_message(object_get_name(handle_parse(db_read(db_b, "test obj reference"))));
show_debug_message("");

db_c = db_create();
db_write(db_c, { a: 0 }, "test");
db_write(db_c, 1, "test", "a");
db_write(db_c, 2, "test", "b");
db_patch(db_c, { c: [3, 3] }, "test");

show_debug_message("=== db_c ===");
show_debug_message(db_get_debug_string(db_c));
show_debug_message("");
db_patch(db_c, [pointer_null, 10], "test", "c");
show_debug_message(db_get_debug_string(db_c));
show_debug_message("");

db_d = db_create();
db_write(db_d, 1, "a");
db_write(db_d, 2, "b");
db_write(db_d, 3, "c", "d");
show_debug_message("=== db_d ===");
show_debug_message(db_get_debug_string(db_d));
show_debug_message("");

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

show_debug_message("=== db_e ===");
show_debug_message(db_read_then_default(db_e, "structs", "a"));
show_debug_message(db_read_then_default(db_e, "structs", "b"));
show_debug_message(db_read_then_default(db_e, "structs", "c"));
show_debug_message(db_read_then_default(db_e, "defaults", "no_default", "first"));
show_debug_message(db_read_then_default(db_e, "defaults", "a", "first"));
show_debug_message(db_read_then_default(db_e, "defaults", "b", "second"));
show_debug_message(db_read_then_default(db_e, "arrays", 42));
show_debug_message(db_read_then_default(db_e, "arrays_with_nesting", 7, "a"));
show_debug_message(db_read_then_default(db_e, "arrays_with_nesting", 7, "b"));
show_debug_message("");