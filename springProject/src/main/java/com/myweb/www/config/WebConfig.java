package com.myweb.www.config;

import javax.servlet.Filter;
import javax.servlet.MultipartConfigElement;
import javax.servlet.ServletRegistration;


import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class WebConfig extends AbstractAnnotationConfigDispatcherServletInitializer{

	@Override
	protected Class<?>[] getRootConfigClasses() {
		// TODO Auto-generated method stub
		return new Class[] {RootConfig.class, SecurityConfig.class};
	}

	@Override
	protected Class<?>[] getServletConfigClasses() {
		// TODO Auto-generated method stub
		return new Class[] {ServletConfiguration.class};
	}

	@Override
	protected String[] getServletMappings() {
		// TODO Auto-generated method stub
		return new String[] {"/"};
	}

	@Override
	protected Filter[] getServletFilters() {
		// encoding filter 설정
		CharacterEncodingFilter encodingFilter = new CharacterEncodingFilter();
		encodingFilter.setEncoding("UTF-8");
		encodingFilter.setForceEncoding(true); //외부로 나가는 데이터도 인코딩 설정
		return new Filter[] {encodingFilter};
	}

	@Override
	protected void customizeRegistration(ServletRegistration.Dynamic registration) {
		// 그외 기타 사용자 설정
		// 사용자 지정 익셉션 설정을 할것인지 처리
		registration.setInitParameter("throwExceptionIfNoHandlerFound", "true");
		
		//파일 업로드 설정
		//경로, maxFileSize, maxReqSize, fileSizeThreshold
		String uploadLocation = "D:\\_myweb\\_java\\fileUpload";
		int maxFileSize = 1024*1024*20; //20MB
		int maxReqSize = maxFileSize*2; //40MB
		int fileSizeThreshold = maxFileSize; //20MB
		
		MultipartConfigElement multipartConfig = 
				new MultipartConfigElement(uploadLocation,maxFileSize,maxReqSize,fileSizeThreshold);
		
		registration.setMultipartConfig(multipartConfig);
	}
	

}
