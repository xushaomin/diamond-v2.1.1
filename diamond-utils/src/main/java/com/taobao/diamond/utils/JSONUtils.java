package com.taobao.diamond.utils;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

public class JSONUtils {

	static ObjectMapper mapper = new ObjectMapper();
	
    public static String serializeObject(Object o) throws Exception {
        return mapper.writeValueAsString(o);
    }

    public static Object deserializeObject(String s, Class<?> clazz) throws Exception {
        return mapper.readValue(s, clazz);
    }
    
    public static Object deserializeObject(String s, TypeReference<?> typeReference) throws Exception {
        return mapper.readValue(s, typeReference);
    }
    
}
