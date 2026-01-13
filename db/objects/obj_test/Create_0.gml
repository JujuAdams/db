show_debug_message("");

db_a = db_create();
db_write(db_a, 10, "test", 0, "test 2");
db_write(db_a, object_index, "test obj reference");
db_debug_save(db_a, "a.json");

db_b = db_debug_load("a.json");
show_debug_message(db_read(db_b, 0, "test", 0, "test 2"));
show_debug_message(object_get_name(handle_parse(db_read(db_b, undefined, "test obj reference"))));
show_debug_message("");

db_c = db_create();
db_write(db_c, { a: 0 }, "test");
db_write(db_c, 1, "test", "a");
db_write(db_c, 2, "test", "b");
db_patch(db_c, { c: [3, 3] }, "test");
show_debug_message(db_get_debug_string(db_c));
show_debug_message("");
db_patch(db_c, [pointer_null, 10], "test", "c");
show_debug_message(db_get_debug_string(db_c));
show_debug_message("");

db_d = db_create();
db_write(db_d, 1, "a");
db_write(db_d, 2, "b");
db_write(db_d, 3, "c", "d");
show_debug_message(db_get_debug_string(db_d));
show_debug_message("");