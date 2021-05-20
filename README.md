# Welcome to the Child Health Biostatistics Core

## Biostatistics Consulting Guidelines

### Overview
Biostatisticians are available to consult with junior investigators, fellows, and students at the BDC who do not have grant funding and/or access to a statistician.

We currently have two biostatisticians available to consult:
- Laura Pyle, PhD
- Tim Vigers, MS


### How to Register a New Project
Email [Laura Pyle](laura.pyle@ucdenver.edu) or [submit a request](https://redcap.ucdenver.edu/surveys/?s=MP9WKRLK74)

### Services Provided
- Study design, sample size estimation/power calculations
- Randomization schemes
- REDCap database design consultation
- Data analysis
- Grant/proposal preparation, protocol review
- Abstract and manuscript preparation
- Data and Safety Monitoring Boards (DSMBs), Scholarly Oversight Committees (SOCs)
- Biostatistics education


### Timelines and Prioritization
- In order to help us manage work requests, please contact us 4 weeks prior to any specific deadlines (e.g., abstract submission, grant deadlines, etc.). For data analysis projects, complete data must also be received 4 weeks prior to any deadlines.
- Projects will be prioritized on a first-come, first-served basis, unless otherwise discussed and mutually agreed upon. Investigators with multiple projects will be asked to indicate the order of priority.
- ADA abstracts: The initial meeting should take place before late November.  Plan to have abstracts completed prior to the holidays.
- Summer students: Let us know about summer student projects at least 4 weeks in advance of their start date.

### Analysis Plans
- For a new data analysis, please bring a draft analysis plan with research questions and hypotheses to the first meeting.  During that meeting, the statistician will work with you to ensure that the analysis plan is clear.  
- A finalized analysis plan, agreed to by both the investigator and the statistician, is required prior to beginning analysis.  Any changes to the plan must be agreed to by both parties.
	
### Grant submissions
#### Budgeting: 
- Any grant proposals submitted with the assistance of the biostatistician should include support for a statistician in the budget, if allowed by the grant mechanism.  
- Typical FTE amounts are 5% for projects with minimal statistical needs and 10% for standard biostatistical support.  Effort can be shared by PhD and MS statisticians as needed.  If the statistical work is substantial (e.g., machine learning, new methods, multi-omics, pathway analyses), please discuss with Dr. Pyle.
- For career development awards, if it is not feasible to include biostatistics support in the budget, the mentor should provide funding; only in cases where the mentor has no funding should section funds be used.
- **The biostatistics budget must be approved in advance by Dr. Pyle.**  
#### Proposal development: 
- **Aims should be finalized at least 3 weeks** before the power calculations and analysis plan are required.  We may not be able to make changes to the analytic strategy if the aims change significantly after that point.
- Any preliminary data to be analyzed should be in a format that follows the guidelines provided below for analytical datasets.  

### Student projects
- The written analysis plan for student projects should be formulated by the student and the PI prior to contacting a biostatistician.  
- The PI should review the final, clean dataset with the student before sending to the biostatistician.  
- Biostatistical support is a limited resource; therefore, students will be responsible for creating their own tables.  Training will be provided on how to perform simple analyses such as t-tests and correlations; biostatisticians will not perform these types of analyses for students as this is expected as part of the student’s educational plan.

### Policy Regarding Authorship and Manuscripts
Please visit http://www.icmje.org/ for details about the International Committee of Medical Journal Editors (ICMJE) guidelines concerning authorship.  Specifically, the biostatistician who performs the analysis makes a significant intellectual contribution and will be listed as a co-author on presentations and publications. The biostatistician may assist with hypothesis generation and study design, and in general performs the analysis, writes the “statistical methods” section of the paper, contributes to the results and discussion sections, reviews the publication, and assists with any revisions required before publication. 

### Policy Regarding Data Cleaning and Management
 
Analysis datasets must be cleaned and in a format ready for analysis.  All datasets should be provided as either REDCap databases or CSV (comma-separated values) files. When available, raw data used to generate calculated analysis variables should also be provided.
 
#### Before You Start
- Is REDCap an option? If yes, use an existing project as a starting template
- New to REDCap? Contact redcap@ucdenver.edu 
 
#### As You Collect Data
- Review with statistician and ask for help
- Leave excluded patients in and reason for excluding, with indicator variable to identify as excluded patient
- Include all essential dates for variables and follow ups
- Datasets sent to the statistician just a few days before an abstract deadline will not be analyzed
- Allow for at least 4 weeks for analysis and write-up/presentation preparation AFTER statistician receives the completed and cleaned dataset
 
#### Before Sending Data to a Statistician
- Review outliers and missing observations (do not remove from the dataset)
- Keep variable names short and meaningful and remove spaces from variable names
- Do not start variable names with a number or special character
- Do not mix character/class and numeric values in the same variable – define as text only if absolutely required
- Use consistent codes for categorical variables (e.g., use a single value such as “male” and do not sometimes use “male,” sometimes “M,” and sometimes “Male.”)
- Use a consistent date format, preferably YYYY-MM-DD.
- Each cell should contain only one piece of information (e.g., instead of a date range like “2015-09-23 to 2016-03-11” use a start date column and end date column, each with a single value)
- Define numeric variables as numeric, not text, and include range checks to prevent invalid data entry
- Remove merged cells and don’t include multiple observations or attributes in a single variable
- Limit text fields to variables not required in the analysis as they can only be used in descriptive reports
- Data on spreadsheets must be free of color/highlighting -   use indicator variables to define groups
- Indicate missing values with either a blank cell or “NA.” Do not use numeric values such as -999
- Be careful about extra spaces in cells (e.g., software will often interpret “ male ”  as different from “male”)
- Data dictionary must be present, understandable, and include a coding guide for numeric variables
- Make data rectangular and preferably in the “long” format. This means that in a longitudinal study, each observation of each participant will have its own row, with one column per variable. For example:

|subject_id|timepoint|measure_1|measure_2|
|----------|---------|---------|---------|
|1|1|2542|0.1|
|1|2|1345|0.3|
|1|3|1000|NA|
|2|1|3256|0.|2|
|2|2|2346|0.|5|
|2|3|4256|0.3|

#### If Sending Multiple Files or Using Multiple REDCap Databases
- If sending multiple files, please include **all files in a single folder** unless a different organization system is absolutely necessary.
- Make sure variable names are exactly the same across all files (e.g., do not use “sensor glucose” in one file and “SG” in another).
- Use consistent subject and (if relevant) timepoint identifiers across all files
- **Use consistent, informative file names including participant ID and timepoint, preferably without spaces** (e.g., “1_baseline_cgm_data.csv”, “1_6week_cgm_data.csv”, “2_baseline_cgm_data.csv”, “2_6week_cgm_data.csv”, etc.)

Many of these guidelines come from Karl Broman and Kara Woo’s [excellent paper on data organization](https://doi.org/10.1080/00031305.2017.1375989). We encourage investigators to read this paper thoroughly before sending data or planning a REDCap database.
