global class RemindBirthAdocao implements Schedulable {
    
    private List<Adocao__c> adocoes;
    
    global void execute(SchedulableContext ctx) {
        
        Integer day = System.today().day();
        Integer month = System.today().month();
        Integer year = System.today().year();
        
        adocoes = [SELECT Id, Name, OwnerId, Data__c, Pet__r.Name, Contato__r.Name
                                    FROM Adocao__c
                                    WHERE CALENDAR_MONTH(Data__c) = :month
                                          AND DAY_IN_MONTH(Data__c) = :day
                                          AND CALENDAR_YEAR(Data__c) <   :year
                                          AND Status__c = 'Aprovada'];

        TaskUtils.createTaskforAdocao(adocoes);
        
    }
}