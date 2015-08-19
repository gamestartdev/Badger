package org.gamestartschool.codemage;


import java.util.Map;

class CodeMageCollections  {
	
	private CodeMageCollections() {}
	
	public static final ACodeMageCollection<MongoUser> users = new ACodeMageCollection<MongoUser>("users") {

		@Override
		MongoUser ConstructEntity(String id, Map<String, Object> fields) {
			String username = (String) fields.get("username");
			String role = (String)fields.get("role");
			return new MongoUser(username, role);
		}
	};
	
	public static final ACodeMageCollection<MongoSpell> spells = new ACodeMageCollection<MongoSpell>("spells") {

		@Override
		MongoSpell ConstructEntity(String id, Map<String, Object> fields) {
			String userId = (String) fields.get("userId");
			String enchantmentId = (String) fields.get("enchantmentId");
			String name = (String) fields.get("name");
			String code = (String)fields.get("code");
			return new MongoSpell(userId, enchantmentId, name, code);
		}
	};
	
	public static final ACodeMageCollection<MongoEnchantment> enchantments = new ACodeMageCollection<MongoEnchantment>("enchantments") {

		@Override
		MongoEnchantment ConstructEntity(String id, Map<String, Object> fields) {
			String name = (String) fields.get("name");
			String trigger = (String) fields.get("trigger");
			String binding = (String) fields.get("binding");
			String minecraftPlayerId = (String) fields.get("minecraftPlayerId");
			Object spellIdsRaw = fields.get("spellIds");
			MongoSpell[] mongoSpells = (MongoSpell[]) spellIdsRaw;
			return new MongoEnchantment(name, binding, trigger,minecraftPlayerId, mongoSpells);
		}
	};
}
