package org.gamestartschool.codemage;

import java.util.List;
import java.util.Map;

import org.gamestartschool.codemage.Main.EDummyEnchantmentBinding;
import org.gamestartschool.codemage.Main.EDummyEnchantmentTrigger;

import ch.lambdaj.function.convert.Converter;
import static ch.lambdaj.Lambda.*;

class CodeMageCollections {

	private CodeMageCollections() {
	}

	public static final ACodeMageCollection<MongoUser> users = new ACodeMageCollection<MongoUser>("users") {

		@Override
		MongoUser ConstructEntity(String id, Map<String, Object> fields) {
			String meteorUsername = (String) fields.get("username");
			String minecraftPlayerId = (String) fields.get("minecraftPlayerId");
			String role = (String) fields.get("role");
			return new MongoUser(id, meteorUsername, minecraftPlayerId, role);
		}
	};

	public static final ACodeMageCollection<MongoSpell> spells = new ACodeMageCollection<MongoSpell>("spells") {

		@Override
		MongoSpell ConstructEntity(String id, Map<String, Object> fields) {
			String userId = (String) fields.get("userId");
			String tombId = (String) fields.get("tombId");
			String name = (String) fields.get("name");
			String code = (String) fields.get("code");
			return new MongoSpell(id, userId, tombId, name, code);
		}
	};

	public static final ACodeMageCollection<MongoEnchantment> enchantments = new ACodeMageCollection<MongoEnchantment>(
			"enchantments") {

		@Override
		MongoEnchantment ConstructEntity(String id, Map<String, Object> fields) {

			
			String userId = (String) fields.get("userId");
			String name = (String) fields.get("name");
			String bindingString = (String) fields.get("binding");
			String bindingTrigger = (String) fields.get("trigger");
			List<String> spellIds = (List<String>)fields.get("spellIds");
			
			IEnchantmentBinding binding =  EDummyEnchantmentBinding.valueOf(bindingString.toUpperCase());
			IEnchantmentTrigger trigger =  EDummyEnchantmentTrigger.valueOf(bindingTrigger.toUpperCase());
			
			return new MongoEnchantment(id, userId, name, binding, trigger, spellIds);
		}
		
		
	};
	

}
