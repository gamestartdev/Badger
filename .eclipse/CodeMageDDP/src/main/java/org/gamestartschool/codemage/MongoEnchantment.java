package org.gamestartschool.codemage;

import org.gamestartschool.codemage.Main.EDummyEnchantmentBinding;
import org.gamestartschool.codemage.Main.EDummyEnchantmentTrigger;

class MongoEnchantment implements IEnchantment, IMongoDocument {
	public final String name;
	public final String trigger;
	public String minecraftPlayerId;
	public String binding;
	public MongoSpell[] spells;
	
	public MongoEnchantment(String name, String binding, String trigger, String minecraftPlayerId, MongoSpell[] spells) {
		this.name = name;
		this.binding = binding;
		this.trigger = trigger;
		this.minecraftPlayerId = minecraftPlayerId;
		this.spells = spells;
	}
	
	@Override
	public String getName() {
		return name;
	}
	
	@Override
	public String getMinecraftPlayerId() {
		return minecraftPlayerId;
	}

	@Override
	public IEnchantmentBinding getBinding() {
		return EDummyEnchantmentBinding.valueOf(binding);
	}

	@Override
	public IEnchantmentTrigger getTrigger() {
		return EDummyEnchantmentTrigger.valueOf(trigger);
	}

	@Override
	public ISpell[] getSpells() {
		return spells;
	}
}