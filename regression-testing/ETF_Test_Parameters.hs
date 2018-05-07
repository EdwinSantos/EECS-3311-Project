module ETF_Test_Parameters where

data OperatingSystem = Linux | MacOSX

-- Should the regression testing proceeds with a list 
-- of expected files, or the oracle?
-- When this flag is set True, the the value of 'oracle' is ignored. 
is_expected = False

-- Specify where you put the oracle.
oracle = "../oracle.exe"

-- Set true if you want the comparison to be tolerant on white spaces and empty lines.
is_tolerant_on_white_spaces = True

-- Specify the path of the executable built from your project.  
executable :: OperatingSystem -> FilePath
--executable MacOSX = "./tracker.osx.exe"
-- executable MacOSX = "./osx"
-- /home/user/eecs3311/project/Project/tracker/EIFGENs/tracker/W_code/
-- ..tracker/EIFGENs/tracker/W_code/tracker
executable Linux  = "../tracker/EIFGENs/tracker/W_code/tracker"

-- Specify where you want to log the outputs 
-- from both the oracle and your executable.
-- In the case 'is_expected' is set to True, 
--   expected output files are copied from the directory 
-- containing 'acceptance_tests' into 'log_dir'
-- In the case 'is_expected' is set to False,
--   expected output files are generated using 'oracle' into 'log_dir'
log_dir = "./log"

-- Specify the list of (relative or absolute) paths of the acceptance test files.
 --   [ "../at1.txt", "../at2.txt" ]
acceptance_tests =  ["../tracker/tests/acceptance/student/at1.txt" ,"../tracker/tests/acceptance/student/at2.txt" ,"../tracker/tests/acceptance/student/at3.txt" ,"../tracker/tests/acceptance/student/at4.txt" , "../tracker/tests/acceptance/student/error1.txt" , "../tracker/tests/acceptance/student/error2.txt" , "../tracker/tests/acceptance/student/error3.txt" , "../tracker/tests/acceptance/student/error4.txt" , "../tracker/tests/acceptance/student/error5.txt" , "../tracker/tests/acceptance/student/error6.txt" , "../tracker/tests/acceptance/student/error7.txt" , "../tracker/tests/acceptance/student/error8.txt" , "../tracker/tests/acceptance/student/error9.txt" , "../tracker/tests/acceptance/student/error10.txt" , "../tracker/tests/acceptance/student/error11.txt" , "../tracker/tests/acceptance/student/error12.txt" , "../tracker/tests/acceptance/student/error13.txt" , "../tracker/tests/acceptance/student/error14.txt" , "../tracker/tests/acceptance/student/error15.txt" , "../tracker/tests/acceptance/student/error16.txt" , "../tracker/tests/acceptance/student/error17.txt" , "../tracker/tests/acceptance/student/error18.txt" , "../tracker/tests/acceptance/student/error19.txt" , "../tracker/tests/acceptance/student/error20.txt" ]
