package com.test.gisttest;

import static org.junit.Assert.assertTrue;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.junit.Test;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;

import cucumber.api.CucumberOptions;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;

@CucumberOptions(features ="src/test/resources")
public class TestKarte {

	    
	    @Test
	    public void testParallel() {
	        System.setProperty("karate.env", "demo"); // ensure reset if other tests (e.g. mock) had set env in CI
	        Results results = Runner.parallel(getClass(), 5);
	        System.out.println(results.getReportDir());
	        generateReport(results.getReportDir());
	        assertTrue(results.getErrorMessages(), results.getFailCount() == 0);        
	    }
	    
	    public static void generateReport(String karateOutputPath) {        
	        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
	        List<String> jsonPaths = new ArrayList(jsonFiles.size());
	        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
	        Configuration config = new Configuration(new File("target"), "demo");
	        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
	        reportBuilder.generateReports();        
	    }
}
