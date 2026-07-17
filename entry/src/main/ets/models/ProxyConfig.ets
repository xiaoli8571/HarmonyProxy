export class NodeModel {


  id:string


  name:string


  type:string


  server:string


  port:number


  delay:number = 0


  enabled:boolean = false


  constructor(
    id:string,
    name:string,
    type:string,
    server:string,
    port:number
  ){

    this.id=id
    this.name=name
    this.type=type
    this.server=server
    this.port=port

  }


}