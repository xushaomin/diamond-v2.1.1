/*
 * (C) 2007-2012 Alibaba Group Holding Limited.
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 * Authors:
 *   leiwen <chrisredfield1985@126.com> , boyan <killme2008@gmail.com>
 */
package com.taobao.diamond.server.service;

import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.taobao.diamond.domain.ConfigInfo;
import com.taobao.diamond.md5.MD5;


@Service("md5CacheService")
public class Md5CacheService {
    
    @Autowired
    private ImportService importService;

    /**
     * content的MD5的缓存,key为group/dataId，value为md5值
     */
    private final ConcurrentHashMap<String, String> contentMD5Cache = new ConcurrentHashMap<String, String>();
   
    public void updateMD5Cache(ConfigInfo configInfo) {
    	String md5CacheKey = generateMD5CacheKey(configInfo.getDataId(), configInfo.getGroup());
        this.contentMD5Cache.put(md5CacheKey, MD5.getInstance().getMD5String(configInfo.getContent()));
    }
    
    public void put(String key, String value) {
        this.contentMD5Cache.put(key, value);
    }

    public String getContentMD5(String dataId, String group) {
        String key = generateMD5CacheKey(dataId, group);
        String md5 = this.contentMD5Cache.get(key);
        if (md5 == null) {
            synchronized (this) {
                // 二重检查
                return this.contentMD5Cache.get(key);
            }
        }
        else {
            return md5;
        }
    }

    public String generateMD5CacheKey(String dataId, String group) {
        String key = group + "/" + dataId;
        return key;
    }
    
    public void updateMD5CacheWithImport(ConfigInfo configInfo) {
    	String md5CacheKey = generateMD5CacheKey(configInfo.getDataId(), configInfo.getGroup());
    	String content = importService.getConentWithImport(configInfo.getContent());
        this.contentMD5Cache.put(md5CacheKey, MD5.getInstance().getMD5String(content));
    }
    
    public void removeMD5Cache(String dataId, String group) {
    	String md5CacheKey = generateMD5CacheKey(dataId, group);
        this.contentMD5Cache.remove(md5CacheKey);
    }
    
    public void removeMD5Cache(ConfigInfo configInfo) {
    	String md5CacheKey = generateMD5CacheKey(configInfo.getDataId(), configInfo.getGroup());
        this.contentMD5Cache.remove(md5CacheKey);
    }

}
