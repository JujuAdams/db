dbA = DbCreate();
DbWrite(dbA, 10,    "test", 0, "test 2");
DbSave(dbA, "a.json", true, true);

dbB = DbLoad("a.json");
show_debug_message(DbRead(dbB, 0,    "test", 0, "test 2"));