package org.gamestartschool.codemage;


class MongoSpell implements IMongoDocument, ISpell {
	public String code;
	public String userId;
	public String name;
	public String id;
	public String tombId;

	public MongoSpell(String id, String userId, String tombId, String name, String code) {
		this.id = id;
		this.userId = userId;
		this.tombId = tombId;
		this.name = name;
		this.code = code;
	}

	@Override
	public String toString() {
		return "MongoSpell [code=" + code + ", userId=" + userId + ", name=" + name + ", id=" + id + ", tombId="
				+ tombId + "]";
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
	public String getId() {
		return id;
	}
}