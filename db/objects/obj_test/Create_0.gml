dbA = dbCreate();
dbWrite(dbA, 10,    "test", 0, "test 2");
dbSave(dbA, "a.json", true, true);

dbB = dbLoad("a.json");
show_debug_message(dbRead(dbB, 0,    "test", 0, "test 2"));