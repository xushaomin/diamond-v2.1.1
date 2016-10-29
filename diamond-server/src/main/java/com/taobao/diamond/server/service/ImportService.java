package com.taobao.diamond.server.service;

import java.io.BufferedReader;
import java.io.StringReader;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.taobao.diamond.domain.ConfigInfo;

/**
 * Import操作服务
 * 
 * @author boyan
 * @date 2010-5-4
 */
@Service
public class ImportService {

	private static final Log log = LogFactory.getLog(ImportService.class);

	@Autowired
	private PersistService persistService;

	public String getConentWithImport(String content) {
		if (content.contains("diamond.import=")) {
			try {
				StringReader reader = new StringReader(content);
				BufferedReader br = new BufferedReader(reader);
				String line = "";

				while ((line = br.readLine()) != null) {
					String[] arrs = line.replaceAll(" ", "").split("=");
					if(arrs.length == 2) {
						String[] keys = arrs[1].split(":");
						String groupKey = keys[0];
						String dataIdKey = keys[1];
						ConfigInfo importConfig = persistService.findConfigInfo(dataIdKey, groupKey);
						if (null != importConfig) {
							content = content + "\n" + importConfig.getContent();
						}
					}
				}
				br.close();
			} catch (Exception e) {
				log.error(e);
			}
		}
		return content;
	}

}
