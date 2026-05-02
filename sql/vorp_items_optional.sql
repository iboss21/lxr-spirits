-- ============================================================================
-- 🐺 LXR-SPIRITS :: Optional VORP Item Registration
-- wolves.land — The Land of Wolves | The Lux Empire
-- ============================================================================

INSERT IGNORE INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `metadata`, `desc`) VALUES
('ritual_sage_bundle', 'Ritual Sage Bundle', 10, 1, 'item_standard', 1, '{}', 'A sacred sage bundle burned during ancestral spirit rituals.'),
('dream_root', 'Dream Root', 10, 1, 'item_standard', 1, '{}', 'A bitter root used to open the mind during spirit visions.'),
('blessed_water', 'Blessed Water', 10, 1, 'item_standard', 1, '{}', 'Water prepared for cleansing rites and sacred ceremonies.'),
('moon_water', 'Moon Water', 10, 1, 'item_standard', 1, '{}', 'Water left under moonlight and used in spiritual cleansing.'),
('spirit_token', 'Spirit Token', 10, 1, 'item_standard', 1, '{}', 'A small token used to strengthen a bond with a spirit guide.'),
('spirit_ash', 'Spirit Ash', 20, 1, 'item_standard', 1, '{}', 'Fine ash left after ritual fire.'),
('spirit_candle', 'Spirit Candle', 20, 1, 'item_standard', 1, '{}', 'A candle used to mark sacred ground.'),
('ancestral_totem', 'Ancestral Totem', 5, 1, 'item_standard', 1, '{}', 'A carved totem used in ancestral ceremonies.'),
('ritual_bone_charm', 'Ritual Bone Charm', 10, 1, 'item_standard', 1, '{}', 'A carved bone charm used in spirit-bond rituals.'),
('ritual_spirit_bowl', 'Ritual Spirit Bowl', 5, 1, 'item_standard', 1, '{}', 'A ceremonial bowl used to hold spirit offerings.');
