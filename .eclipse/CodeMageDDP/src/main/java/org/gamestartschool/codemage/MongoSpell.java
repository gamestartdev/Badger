package org.gamestartschool.codemage;


class MongoSpell implements IMongoDocument, ISpell {
	public String code;
	public String enchantmentId;
	public String userId;
	public String name;

	public MongoSpell(String userId, String enchantmentId, String name, String code) {
		this.userId = userId;
		this.name = name;
		this.code = code;
		this.enchantmentId = enchantmentId;
	}

	@Override
	public String toString() {
		return "MongoSpell [name=" +name+ ", code=" + code + ", enchantmentId=" + enchantmentId + ", userId=" + userId + "]";
	}

	@Override
	public String getCode() {
		return code;
	}

	@Override
	public String getName() {
		return name;
	}
	
	@Override
	public IEnchantment getEnchantment() {
		return CodeMageCollections.enchantments.get(enchantmentId);
	}
}