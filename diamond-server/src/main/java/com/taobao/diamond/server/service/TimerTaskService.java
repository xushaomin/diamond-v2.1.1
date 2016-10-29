package com.taobao.diamond.server.service;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.TimeUnit;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.taobao.diamond.server.utils.SystemConfig;

/**
 * 定时任务服务
 * 
 * @author boyan
 */
@Service
public class TimerTaskService {

	private static final String THREAD_NAME = "diamond dump config thread";

	@Autowired
	private PersistService persistService;

	@Autowired
	private DiskService diskService;

	@Autowired
	private ConfigService configService;

	@Autowired
	private Md5CacheService md5CacheService;
	
	@Autowired
	private ImportService importService;

	private ScheduledExecutorService scheduledExecutorService;

	@PostConstruct
	public void init() {
		this.scheduledExecutorService = Executors.newSingleThreadScheduledExecutor(new ThreadFactory() {
			public Thread newThread(Runnable r) {
				Thread t = new Thread(r);
				t.setName(THREAD_NAME);
				t.setDaemon(true);
				return t;
			}
		});

		DumpConfigInfoTask dumpTask = new DumpConfigInfoTask(this);
		dumpTask.run();
		this.scheduledExecutorService.scheduleWithFixedDelay(dumpTask, SystemConfig.getDumpConfigInterval(),
				SystemConfig.getDumpConfigInterval(), TimeUnit.SECONDS);
	}

	@PreDestroy
	public void dispose() {
		if (this.scheduledExecutorService != null) {
			this.scheduledExecutorService.shutdown();
		}
	}

	public void setPersistService(PersistService persistService) {
		this.persistService = persistService;
	}

	public PersistService getPersistService() {
		return persistService;
	}

	public void setDiskService(DiskService diskService) {
		this.diskService = diskService;
	}

	public ConfigService getConfigService() {
		return configService;
	}

	public void setConfigService(ConfigService configService) {
		this.configService = configService;
	}

	public DiskService getDiskService() {
		return diskService;
	}

	public Md5CacheService getMd5CacheService() {
		return md5CacheService;
	}

	public void setMd5CacheService(Md5CacheService md5CacheService) {
		this.md5CacheService = md5CacheService;
	}

	public ImportService getImportService() {
		return importService;
	}

	public void setImportService(ImportService importService) {
		this.importService = importService;
	}

}
