import {appStore} from '../store/AppStore'


export class ProxyService {


  start(){

    appStore.start()

  }


  stop(){

    appStore.stop()

  }


  status(){

    return appStore.state

  }

}


export const proxyService =
  new ProxyService()