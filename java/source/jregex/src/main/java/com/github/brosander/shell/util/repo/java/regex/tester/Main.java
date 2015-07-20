package com.github.brosander.shell.util.repo.java.regex.tester;

import org.apache.commons.cli.*;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by bryan on 7/20/15.
 */
public class Main {
    private static void printUsage(Options options) {
        new HelpFormatter().printHelp("jregex", options);
    }

    public static void main(String[] args) {
        Options options = new Options();
        options.addOption("r", "regex", true, "The regular expression to test");
        options.addOption("t", "test", true, "A test string (multiple -t flags allowed)");
        CommandLineParser parser = new DefaultParser();
        CommandLine parse;
        try {
            parse = parser.parse(options, args);
        } catch (ParseException e) {
            System.err.println("Error parsing command line: " + e.getMessage());
            printUsage(options);
            return;
        }
        if (!parse.hasOption('r')) {
            System.err.println("Regex (-r) required.");
            printUsage(options);
            return;
        }
        if (!parse.hasOption('t')) {
            System.err.println("At least one test string (-t) required.");
            printUsage(options);
            return;
        }
        String regex = parse.getOptionValue('r');
        System.out.println("Testing pattern (escaped): \"" + regex.replace("\\", "\\\\") + "\"");
        Pattern pattern = Pattern.compile(regex);
        for (String testString : parse.getOptionValues('t')) {
            System.out.println("Testing test string (escaped): \"" + testString + "\"");
            Matcher matcher = pattern.matcher(testString);
            boolean matches = matcher.matches();
            System.out.println("  Match: " + matches);
            if (matches && matcher.groupCount() > 0) {
                for (int i = 0; i < matcher.groupCount() + 1; i++) {
                    System.out.println("  Group " + i + ": " + matcher.group(i));
                }
            }
        }
    }
}
