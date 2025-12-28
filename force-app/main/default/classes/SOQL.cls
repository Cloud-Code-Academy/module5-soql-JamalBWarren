/**
 * The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
 * It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
 *
 * This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
 * a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
 * records, and manage data volume using the LIMIT keyword.
 *
 * Topics covered in this class include:
 * - Understanding the structure of a SOQL query.
 * - Crafting basic SELECT statements in SOQL.
 * - Applying filters using the WHERE clause in SOQL.
 * - Fetching related records using Relationship queries.
 * - Controlling the amount of data retrieved using the LIMIT keyword.
 *
 * Users of this class can expect to gain a solid understanding of SOQL in Apex and
 * be prepared to handle data retrieval tasks in Salesforce development.
 *
 * @author Your Name
 */

public with sharing class SOQL {
	/**
	 * Question 1
	 * Update/Uncomment the template code to create a method
	 * Returns all leads from Salesforce Org
	 * @return List of all leads with Id, LastName, Company, Phone, Email
	 * Update the corresponding test class and testGetAllLeads method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
		public static List<Lead> getAllLeads(){
			try{
				List<Lead> resultLeads =  [SELECT Id, LastName, Company, Phone, Email FROM Lead];
				return resultLeads;
			}catch(Exception e){
				System.debug('Something went wrong when finding Leads. Error:'  + e.getMessage());
				return new List<Lead>();
			}
		} 

	/**
	 * Question 2
	 * Update/Uncomment the template code to create a method
	 * Returns all contacts with first name of John.
	 * @return A list of Contact records.
	 * Update the corresponding test class and testGetContactsByFirstName method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
		public static List<Contact> getContactsByFirstName(){
			try{
				List<Contact> resultContacts =  [SELECT Id, FirstName, LastName FROM Contact WHERE
												FirstName = 'John'];
				
				return resultContacts;
			}catch(Exception e){
				System.debug('Something went wrong when finding Contacts. Error: ' 
								+ e.getMessage());
				return new List<Contact>();
			}
		}

	/**
	 * Question 3
	 * Update/Uncomment the template code to create a method
	 * Returns the Contact Id for all contacts with last name of Smith or Jones
	 * @return A list of Contact Ids.
	 * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
	public static List<Id> getContactIdsByLastName(){
			try{
				Map<Id, Contact> contactIds =  new Map<Id, Contact>([SELECT Id FROM Contact
													WHERE LastName IN ('Smith', 'Jones')]);
				
				return new List<Id>(contactIds.keySet());	
			
			}catch(Exception e){
				System.debug('Something went wrong findings Contacts. Error: ' + 
							e.getMessage());
				return new List<Id>();
			}
	}

	/**
	 * Question 4
	 * Update/Uncomment the template code to create a method
	 * Returns List of closed won opportunities for a specific Account.
	 * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A list of Opportunities with important opportunities fields
	 * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
	public static List<Opportunity> getClosedWonOpportunityCountByAccount(Id accountId){
		try{
			List<Opportunity> resultOpps = [SELECT Id, Name, Stagename, CloseDate, Createddate, 
											Amount, AccountId FROM Opportunity WHERE AccountId = :accountId AND StageName = 'Closed Won'];		
			//getting the stagename returned seems redundant, but i don't know if there's a reason to do so or not?
			return resultOpps;
		}catch(Exception e){
			System.debug('Something went wrong when getting Opps. Error: ' +
							e.getMessage());
			return new List <Opportunity>();
		}
	}


	/**
	 * Question 5
	 * Update/Uncomment the template code to create a method
	 * Returns the total count of Account records.
	 * @return The Integer count of Account records.
	 * Update the corresponding test class and testGetAccountCount method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
	public static Integer getAccountCount(){
		try{
			Integer accCount = 0;
			for(Account a : [SELECT Id FROM Account]){
				accCount += 1;
			}

			return accCount;
		}catch(Exception e){
			System.debug('Something went wrong with getting Account count ' + e.getMessage());

			return 0;
		}
	}
	/**
	 * Question 6
	 * Update/Uncomment the template code to create a method
	 * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
	 * @return A map of Task Ids to Task records.
	 * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
	public static Map<Id, Task> getTasksDueNextWeek(){
		try{
			Map<Id, Task> resultTaskMap = new Map<Id, Task>([SELECT Id, ActivityDate FROM Task 
												 WHERE ActivityDate = NEXT_N_DAYS:7]);
			return resultTaskMap;

		}catch(Exception e){
			System.debug('Something went wrong with the Task list ' + e.getMessage());
			
			return new Map<Id,Task>();
		}
	}

	/**
	 * Question 7
	 * Update/Uncomment the template code to create a method
	 * Retrieves all Contacts that have a example.com domain in their Email.
	 * @return A list of Contact records.
	 * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}

	public static List<Contact> getContactsByEmailDomain(){
		try{
			List<Contact> resultContact = [SELECT Id , FirstName, LastName, Email FROM Contact WHERE Email LIKE
											 '%example.com'];

			return resultContact;

		}catch(Exception e){
			System.debug('Soemthing went wrong looking for example email contacts ' +
								e.getMessage());

			return new List<Contact>();
		}
	}

	/**
	 * Question 8
	 * Retrieves all Opportunities that have a specific keyword in their Name.
	 * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
	 * @param keyword The keyword to search for in the Opportunity Name.
	 * @return A list of Opportunity records.
	 */
	public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {
		
		if(keyword == null){
			return new List<Opportunity>();
		}

		try{
			String searchTerm = '%' + keyword + '%';

			List<Opportunity> keywordOpps = [SELECT Id, Name FROM Opportunity WHERE Name LIKE
												 :searchTerm];
			return keywordOpps;
		
		} catch (Exception e){
			System.debug('Something went wrong with the Opp search: ' + e.getMessage());

			return new List<Opportunity>();
		}
	}

	/**
	 * Question 9
	 * Retrieves all Cases that Case Origin is not Web or Email or Blank
	 * @return A list of Case records.
	 */
	public static List<Case> getFilterCaseOrigins() {
		try{
			List<Case> resultCases = [SELECT Id, Origin FROM Case WHERE Origin NOT 
										IN('Web','Email') AND Origin != ''];
			
			return resultCases;
		}catch(exception e){
			System.debug('Something went wrong looking for case origins: ' + e.getMessage());

			return new List<Case>();
		}
	}

	/**
	 * Question 10
	 * Update/Uncomment the template code to create a method
	 * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
	 * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
	 * @param leadSource The Lead Source to search for.
	 * @param keyword The keyword to search for in the Lead Title.
	 * @return A list of Lead records.
	 * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
	public static List<Lead> getLeadsBySourceOrTitle(String leadSource, String keyword){
		if(leadSource == null && keyword == null){
			return new List<Lead>();
		}
		try{

			String sourceSearch = '%' + leadSource + '%';
			String titleSearch = '%' + keyword + '%';
			List<Lead> foundLeads = [SELECT Id, FirstName, LastName, Company, Phone, Email, LeadSource, Title FROM
										 Lead WHERE LeadSource LIKE :sourceSearch OR Title LIKE :titleSearch];
			return foundLeads;

		}catch(Exception e){
			System.debug('Unable to find Leads by source or keyword:' + e.getMessage());
			return new List<Lead>();
		}
	}

	/**
	 * Question 11
	 * Returns the names of all Contacts associated with an Account.
	 * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A list of Contact LastName.
	 */
	public static List<String> getContactNamesByAccount(Id accountId) {
		if(accountId == null){
			return new List<String>();
		}
		// Create a list to hold the Contact LastNames
		List<Contact> foundContacts = [SELECT Id, LastName FROM Contact WHERE AccountId = :accountId];

		// Query the Contacts
		// Loop through each Contact and add the LastName to the list
		//for () {
		//
		//}
		List<String> allLastNames = new List<String>();

		try{

			for(Contact con : foundContacts){
				allLastNames.add(con.LastName);
			}

			return allLastNames;
		}catch(Exception e){
			System.debug('Unable to get Last Names for contacts: ' + e.getMessage());

			return allLastNames;
		}

	}

	/**
	 * Question 12
	 * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
	 * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for the found opportunities
	 * @param stage The Stage value to filter Opportunities.
	 * @return The total revenue.
	 */
	public static Decimal getTotalRevenueByStage(String stage) {
		// Use AggregateQuery to get the total revenue
		if(stage == null){
			return 0.00;
		}
		Decimal totalRevenueSum = 0.00;

		try{
			List<Opportunity> oppsToSum = [SELECT Name, Amount FROM Opportunity WHERE StageName = :stage];
			
			for(Opportunity opp : oppsToSum){
				totalRevenueSum += opp.Amount;
			} 

			return totalRevenueSum;

		}catch(Exception e){
			System.debug('Unable to get total Revenue by stage: ' + e.getMessage());

			return totalRevenueSum;
		}
		// Return the total revenue
		// Replace null with the variable you used to store the result
	}

	/**
	 * Question 13
	 * Retrieves the first 10 Accounts ordered by Name.
	 * @return A list of the first 10 Accounts ordered by Name.
	 */
	public static List<Account> getFirstTenAccounts() {
		try{
			List<Account> top10Accounts = [SELECT Id, Name FROM Account ORDER BY Name Asc LIMIT 10];

			return top10Accounts;

		}catch(Exception e){
			System.debug('Unable to get the top 10 accounts: ' + e.getMessage());

			return new List<Account>();
		}
		// Replace null with the variable you used to store the result
	}

	/**
	 * Question 14
	 * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
	 * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
	 */
	public static List<Opportunity> getHighValueOpportunities() {
		try{
			List<Opportunity> bigOpps = [SELECT Id, Name, CloseDate, Amount FROM Opportunity WHERE Amount > 100000 ORDER BY CloseDate asc LIMIT 5];

			return bigOpps;
		}catch(Exception e){
			System.debug('There was an issue getting the large value opps: ' + e.getMessage());

			return new List<Opportunity>();
		}
		
		// Replace null with the variable you used to store the result
	}

	/**
	 * Question 15
	 * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
	 * @return A list of Contacts
	 */
	public static List<Contact> getBirthdateContacts() {
		try{
			List<Contact> recentBDayContacts = [SELECT Id, Birthdate FROM Contact ORDER BY Birthdate desc LIMIT 3];
			
			return recentBDayContacts;

		}catch(Exception e){
			System.debug('Unable to find birthday Contacts: ' + e.getMessage());

			return new List<Contact>();
		}

		 // Replace null with the variable you used to store the result
	}

	/**
	 * Question 16
	 * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
	 * @return A list of Cases
	 */
	public static List<Case> getCasesWithStatus() {
		try{
			List<Case> topCasesOffset = [SELECT Id, Status, Createddate FROM Case WHERE Status = 'Open' ORDER BY Createddate asc LIMIT 10 OFFSET 5];
			
			return topCasesOffset;

		}catch(Exception e){
			System.debug(' Unable to pull in Contacs by Createddate Offset ' + e.getMessage());

			return new List<Case>();
		}

		 // Replace null with the variable you used to store the result
	}

	/**
	 * Question 17
	 * Returns Set of Case Ids for a specific Account.
	 * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A set of Case Ids.
	 */
	public static Set<Id> getCaseIdsByAccount(Id accountId) {
		// Create a set to hold the Case Ids
		try{
			if(accountId != null){/*I'm assuming all cases need an account right?*/
				Account acc = [SELECT Id, Name, (SELECT Id, Casenumber FROM Cases) FROM Account WHERE Id = :accountId LIMIT 1];

				Set<Id> childCaseIds = new Set<Id>();
				
				for(Case c : acc.Cases){
					childCaseIds.add(c.Id);
				}
				return childCaseIds;
			}
		}catch(Exception e){
			System.debug('Issue with getting Cases from account' + e.getMessage());

		}
					return new Set<Id>();
	}

	/**
	 * Question 18
	 * Return Map of Account Ids to Account Names Not in a specific Country.
	 * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
	 * @param country The country to filter Accounts.
	 * @return A map of Account Ids to Account Names.
	 */
	public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
		try{
			if(country != null){
				Map<Id, String> accountIdsToNames = new Map<Id, String>();

				List<Account> foundAccs = [SELECT Id, Name FROM Account WHERE BillingCountry != :country];		
					if(foundAccs != null){
						for(Account thisAcc : foundAccs){
							accountIdsToNames.put(thisAcc.Id,thisAcc.Name); 
						}
					}

					return accountIdsToNames;
			}
		}catch(Exception e){
			System.debug('There was an issue getting accounts outside the country' + e.getMessage());
		}

		return new Map<Id, String>();
	}

	/**
	 * Question 19
	 * Retrieves the Account Name for a given Contact.
	 * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
	 * @param contactId The Id of the Contact.
	 * @return The Account Name of the Contact.
	 */
	public static String getAccountNameForContact(String contactId) {
		if(contactId == null){
			return '';
		}
			try{
				Contact c = [SELECT Id, Name, Account.Name FROM Contact WHERE Id = :contactId];
				String accName = c.Account.Name;

				return accName;

			}catch(Exception e){
				System.debug('There was an issue with pulling in the account name: ' + e.getMessage());

				return '';
			}
	}

	/**
	 * Question 20
	 * Returns single Account that has related opportunities in the same query
	 * Example: getAccountAndOpportunitiesFromAccountId('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
	 * @param accountId The ID of the Account.
	 * @return An Account record with related Opportunities.
	 */
	public static Account getAccountAndOpportunitiesFromAccountId(Id accountId) {
		Account acc = new Account();
		try{
			if(accountId != null){
				acc = [SELECT Id, Name, (SELECT Id, Name, StageName, CloseDate FROM Opportunities)FROM Account WHERE Id = :accountId];

				return acc;
			}
		}catch(Exception e){
			System.debug('There was an issue with getting the account and Opps: ' + e.getMessage());

		}

		return acc;
		
	}

	/**
	 * Question 21
	 * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
	 * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
	 * @param Account Id
	 * @return List of contacts with the same Mailing State as the Account Billing State
	 */
	public static List<Contact> getAccountsWithContactsByState(Id accountId) {
		try{
			Account a = [SELECT Id, Name, BillingState FROM Account WHERE Id = :accountId LIMIT 1];
			List<Contact> con = [SELECT Id, Name, MailingState FROM Contact WHERE MailingState = : a.BillingState ];

			return con;

		}catch (Exception e){

			System.debug('There was an issue getting the Contacts with matching MailingState ' + e.getMessage());

		}

		return new List<Contact>(); // Replace null with the variable you used to store the result
	}

	/**
	 * Question 22
	 * Extracts email domains from them leads, then finds Accounts with matching website domains
	 * If Lead Email = test@test.com return account with website = www.test.com
	 * Example: findAccountsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
	 * @param A set of Lead Ids.
	 * @return A list of Accounts with matching email domains.
	 */
	public static List<Account> findAccountsByLeadEmailDomains(Set<Id> leadIds) {
		try{
			List<Lead> domainLeads = [SELECT Id, Name, Email FROM Lead WHERE Id IN :leadIds];

			Set<String> searchTheseDomains = new Set<String>();

			for(Lead singleLead : domainLeads){
				searchTheseDomains.add('www.' + singleLead.Email.right(singleLead.Email.length() - singleLead.Email.indexOf('@') - 1));
			}

			List<Account> foundAccs = [SELECT Id, Name, Website FROM Account WHERE Website IN :searchTheseDomains];

			return foundAccs;

		}catch(Exception e){
			
			System.debug('There was an issue with getting the Account records :' + e.getMessage());
			
		}

		return new List<Account>();
	}

	/**
	 * Question 23
	 * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
	 * Adds a randomized number between 1 to 3 to the quantity of each line item.
	 * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
	 * @param Original Opportunity Id
	 * @param List of cloned Opportunity Ids
	 */
	public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
		// Query the original Opportunity Line Items
		try{
			List <OpportunityLineItem> createOLI = new List<OpportunityLineItem>();
			List<OpportunityLineItem> originalOLI = [SELECT OpportunityId, PricebookEntryId, Quantity, UnitPrice FROM OpportunityLineItem WHERE 
														OpportunityId = :origOppId];
			for(Id oppId : cloneOppIds){
				for(OpportunityLineItem singOLI : originalOLI){

					OpportunityLineItem newOLI = singOLI.clone(false, true);
					newOLI.OpportunityId = oppId;
					newOLI.Quantity = 1 + Integer.valueOf(Math.floor(Math.random() * 3));

					createOLI.add(newOLI);
				}
			}

			insert createOLI;

		}catch (Exception e){
			System.debug('There was an issue when trying to clone the OLI: ' + e.getMessage());
		}
	}

	/**
	 * Question 24
	 * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
	 * @return A list of filtered Opportunity
	 */
	public static List<Opportunity> getOpportunityDetailsForClosedWon() {
		try{
			List<Opportunity> closedWonOpps = [SELECT Id, Name, Account.Name, Owner.Name FROM Opportunity WHERE StageName = 'Closed Won'];

			return closedWonOpps;

		}catch(Exception e){
			System.debug('There was an issue getting a list of filtered Closed Won opps: ' + e.getMessage());
		}
		return new List<Opportunity>(); // Replace null with the variable you used to store the result
	}

	/**
	 * Question 25
	 * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to the Contact on the associated Account with the alphabetically first first name.
	 * Example: if there are two Contacts on the Account, "Billy" and "Abby," the 'Primary_Contact__c' will be set to "Abby."
	 */
	public static void setPrimaryContact() {

		try{
			Map<Id, Id> accWithPrimaryContactId = new Map<Id, Id>();
			
			for(Account accAndContacts : [SELECT Id, Name, (SELECT Id, FirstName, LastName FROM Contacts WHERE FirstName != null ORDER BY 
												FirstName Asc LIMIT 1) FROM Account WHERE Id IN (SELECT AccountId FROM Opportunity WHERE StageName = 'Closed Won')]){

				accWithPrimaryContactId.put(accAndContacts.Id, accAndContacts.Contacts[0].Id);
												
			}

			List<Opportunity> updateOppList = new List<Opportunity>();

			for(Opportunity o : [SELECT AccountId, Name, Primary_Contact__c FROM Opportunity WHERE StageName = 'Closed Won' AND AccountId IN 
																									:accWithPrimaryContactId.keySet()]){
				o.Primary_Contact__c = accWithPrimaryContactId.get(o.AccountId);
				updateOppList.add(o);
			}

			update updateOppList;

			/* Trying to see if the above works just to test out more sophisticated query structures
			List<Opportunity> closedWonOpportunity = [SELECT Id, Name, AccountId, Primary_Contact__c FROM Opportunity WHERE 
														StageName = 'Closed Won'];

			List<Opportunity> updateOpps;
			Set<Id> oppAccIds;

			for(Opportunity singleOpp : closedWonOpportunity){
				oppAccIds.add(singleOpp.AccountId);
			}


			Map<Id, Account> accWithPrimaryContact = new Map<Id, Account>([SELECT Id, Name, (SELECT Id, FirstName FROM Contacts WHERE FirstName 
														!= null ORDER BY FirstName Desc LIMIT 1) FROM Account WHERE Id IN :oppAccIds]);

			for(Opportunity opp : closedWonOpportunity){
				opp.Primary_Contact__c = accWithPrimaryContact.get(opp.AccountId).Contacts[0].Id;
				updateOpps.add(opp);
			}

			update updateOpps;*/

		}catch(Exception e){

			System.debug('There was an issue with setting the Primary Contact: ' + e.getMessage());
		}
	}
}
