import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
import uploadFile from '@salesforce/apex/FileUploader.uploadFile'
export default class ImageUpload extends LightningElement {
    @api recordId;
    fileData
    openimageUpload(event) {
        const file = event.target.files[0]
        var reader = new FileReader()
        reader.onload =()=>{
            var contentType = reader.result.split(',')[0]
            var base64 = reader.result.split(',')[1]

            this.fileData = {
                'filename':file.name,
                'base64':base64,
                'recordId':this.recordId
            }
            // console.log(this.fileData)
        }
        reader.readAsDataURL(file)
    }

    handleClick() {
        const {base64, filename, recordId} = this.fileData
        uploadFile({base64, filename, recordId}).then(result=>{
            this.fileData = null
            let title = `${filename} enviado com sucesso!`
            this.toast(title)
        })
    }

    toast(title) {
        const toastEvent = new ShowToastEvent({
            title,
            variant:"success"
        })
        this.dispatchEvent(toastEvent)
    }
}