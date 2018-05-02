package hansuo.portalwifi;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

/**
 * 在spring boot中加入相应配置的扫描
 * 
 */
@Configuration
public class ApplicationConfig extends WebMvcConfigurerAdapter {

	@Value("${cbs.imagesPath}")
	private String imagePath;

	@Value("${cbs.videoPath}")
	private String videoPath;

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {

		/*
		 * 说明：增加虚拟路径(用springboot内置的tomcat时有效，
		 * 用外部的tomcat也有效;所以用到外部的tomcat时不需在tomcat/config下的相应文件配置虚拟路径了)
		 */
		registry.addResourceHandler("upload/image/**").addResourceLocations(imagePath);
		registry.addResourceHandler("upload/video/**").addResourceLocations(videoPath);

		super.addResourceHandlers(registry);
	}
}