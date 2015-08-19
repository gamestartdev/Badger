package org.gamestartschool.codemage;


import java.util.ArrayList;
import java.util.Collection;

class MongoUser implements IMongoDocument {

	private String minecraftUserId;
	private String role;

	public MongoUser(String minecraftUserId, String role) {
		this.minecraftUserId = minecraftUserId;
		this.role = role;
	}

	public String getMinecraftUserId() {
		return minecraftUserId;
	}
	
	public Collection<MongoSpell> getSpells() {
		Collection<MongoSpell> all = CodeMageCollections.spells.getAll();
		ArrayList<MongoSpell> spellsForId = new ArrayList<MongoSpell>();
		for (MongoSpell spell : all) {
			if(spell.userId == minecraftUserId) { //Wait MongoId or MinecraftId ??
				spellsForId.add(spell);
			}
		}
		return spellsForId;
	}

	@Override
	public String toString() {
		return "MongoUser [minecraftUserId=" + minecraftUserId + ", role=" + role + "]";
	}
	
	
}
