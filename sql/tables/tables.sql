CREATE TABLE part_config (
    parent_table text NOT NULL,
    type @extschema@.partition_type NOT NULL,
    part_interval text NOT NULL,
    control text NOT NULL,
    premake int NOT NULL DEFAULT 4,
    retention text,
    retention_keep_table boolean NOT NULL DEFAULT true,
    retention_keep_index boolean NOT NULL DEFAULT true,
    datetime_string text,
    last_partition text,
    CONSTRAINT part_config_parent_table_pkey PRIMARY KEY (parent_table)
);
CREATE INDEX part_config_type_idx ON @extschema@.part_config (type);
SELECT pg_catalog.pg_extension_config_dump('part_config', '');


CREATE TABLE part_grants (
    parent_table text,
    grants text,
    roles text,
    CONSTRAINT part_grants_parent_table_fkey FOREIGN KEY (parent_table) REFERENCES @extschema@.part_config (parent_table) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT part_grants_unique_grant UNIQUE (parent_table, grants, roles)
);

