package org.gamestartschool.codemage;


import static ch.lambdaj.Lambda.filter;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import ch.lambdaj.function.matcher.Predicate;

class MongoUser implements IMongoDocument, IUser {

	private String id;
	private String meteorUsername;
	private String minecraftPlayerId;
	private String role;

	public MongoUser(String id, String meteorUsername, String minecraftPlayerId, String role) {
		this.id = id;
		this.meteorUsername = meteorUsername;
		this.minecraftPlayerId = minecraftPlayerId;
		this.role = role;
	}

	@Override
	public String getMinecraftUserId() {
		return minecraftPlayerId;
	}
	
	@Override
	public List<ISpell> getSpells() {
		Collection<MongoSpell> all = CodeMageCollections.spells.getAll();
		ArrayList<ISpell> spellsForId = new ArrayList<ISpell>();
		for (MongoSpell spell : all) {
			if(spell.userId == id) { //Wait MongoId or MinecraftId ??
				spellsForId.add(spell);
			}
		}
		return spellsForId;
	}

	@Override
	public String toString() {
		return "MongoUser [id=" + id + ", meteorUsername=" + meteorUsername + ", minecraftPlayerId=" + minecraftPlayerId
				+ ", role=" + role + "]";
	}

	@Override
	public String getId() {
		return id;
	}
	
	public List<IEnchantment> getEnchantments() {
		Collection<IEnchantment> enchantments = new ArrayList<IEnchantment>(CodeMageCollections.enchantments.getAll());
		return filter(new EnchantmentsByPlayer(), enchantments);
	}

	class EnchantmentsByPlayer extends Predicate<MongoEnchantment> {

		@Override
		public boolean apply(MongoEnchantment e) {
			return id.equals(e.userId);
		}
		
	}
	
}
