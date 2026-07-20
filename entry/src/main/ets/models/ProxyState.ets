@Observed
export class ProxyState {

  running: boolean = false

  connected: boolean = false

  currentNode: string = '未选择'

  uploadSpeed: number = 0

  downloadSpeed: number = 0

  connections: number = 0

}
