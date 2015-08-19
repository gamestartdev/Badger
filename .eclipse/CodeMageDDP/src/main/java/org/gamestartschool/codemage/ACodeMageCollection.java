package org.gamestartschool.codemage;


import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Observable;

import com.keysolutions.ddpclient.DDPClient;
import com.keysolutions.ddpclient.DDPClient.DdpMessageField;
import com.keysolutions.ddpclient.DDPClient.DdpMessageType;
import com.keysolutions.ddpclient.DDPListener;

abstract class ACodeMageCollection<T extends IMongoDocument> extends DDPListener implements ICodeMageCollection<T> {
	
	private String name;
	private boolean isReady = false;
	
	public String getName() {
		return name;
	}
	
	public ACodeMageCollection(String name) {
		this.name = name;
	}
	
	private Map<String, T> documents = new HashMap<String, T>();
	public T get(String id) { return documents.get(id); }
	public Collection<T> getAll() { return documents.values(); }
	
	abstract T ConstructEntity(String id, Map<String, Object> fields);
	
	public T Added(String id, Map<String, Object> fields) {
		T instance = ConstructEntity(id, fields);
		documents.put(id, instance);
		System.out.println("Adding: " + instance);
		return instance;
	}
	
	@Override
	public void onReady(String callId) {
		super.onReady(callId);
		isReady = true;
		System.out.println(name+" Ready!!");
	}
	
	@SuppressWarnings("unchecked")
	@Override
    public void update(Observable client, Object jsonObject) {
        if (jsonObject instanceof Map<?, ?>) {
            Map<String, Object> json = (Map<String, Object>) jsonObject;
            
            if(name.equals(json.get(DdpMessageField.COLLECTION))) {
                String msgtype = (String) json.get(DDPClient.DdpMessageField.MSG);
                
                if (msgtype.equals(DdpMessageType.ADDED)) {
                	
                	try {
                		this.Added((String) json.get(DdpMessageField.ID), (Map<String, Object>) json.get(DdpMessageField.FIELDS));
                	} catch (RuntimeException e){
                		System.out.println("Failed to decode DDP object: "+json);
                	}
                }
            };
        }
    }
	public boolean isReady() {
		return isReady;
	}

	
}