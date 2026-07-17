import NativeProxy from './NativeProxy'


export class ProxyService {


  private static native?: NativeProxy


  static start(){

    if(this.native){

      return this.native.start()

    }

    return false

  }


  static stop(){

    if(this.native){

      return this.native.stop()

    }

    return false

  }


  static status(){

    if(this.native){

      return this.native.status()

    }

    return false

  }


}