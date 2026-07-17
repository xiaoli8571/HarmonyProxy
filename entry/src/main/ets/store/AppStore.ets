import { ProxyState } from '../models/ProxyState'


export class AppStore {

  private static instance: AppStore


  state: ProxyState = {

    running:false,

    connected:false,

    currentNode:'未选择',

    uploadSpeed:0,

    downloadSpeed:0,

    connections:0

  }


  private constructor(){}


  static getInstance():AppStore {

    if(AppStore.instance === undefined || AppStore.instance === null){

      AppStore.instance=new AppStore()

    }

    return AppStore.instance

  }


  start(){

    this.state.running=true

  }


  stop(){

    this.state.running=false

    this.state.connected=false

  }

}


export const appStore =
  AppStore.getInstance()