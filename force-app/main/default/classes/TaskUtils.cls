public with sharing class TaskUtils {
    public static void createTaskforAdocao(List<Adocao__c> adocoes) {

        List<Task> taskList = new List<Task>();
        For(Adocao__c ado : adocoes) {
            Task newTask = new Task(
                WhatId = ado.Id,
                OwnerId = ado.OwnerId,
                ActivityDate = Date.today(),
                Subject = 'Aniversário de adoção',
                Description = 'Hoje o pet '+ado.Pet__r.Name + ' completa mais uma no que foi adotado por ' + ado.Contato__r.Name + '.'
            );

            taskList.add(newTask);
            insert taskList;
        }
        
    }
}