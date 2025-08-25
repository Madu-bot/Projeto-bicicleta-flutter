#include <BLEdevice.h>
#include <BLEUtils.h>
#include <BLEServer.h>
#include <BLEAdvertising.h>
#include <HardwareSerial.h>

#define SERVICE_UUID "4fafc201-1fb5-459e-8fcc-c5c9c331914b"
#define CHARACTERISTIC_UUID "beb5483e-36e1-4688-b7f5-ea07361b26a8"

BLEServer* pServer = NULL;
BLECharacteristic* pCharacteristic = NULL;
bool deviceConnected = false;

int rotacoes_contador = 0;

void setup(){
  Serial.begin(115200);

  BLEDevice::init("BikeSensor");


  pServer = BLEDevice::createServer();

  BLEService *pService = pServer->createService(SERVICE_UUID);

  pCharacteristic = pService ->createCharacteristic(
    CHARACTERISTIC_UUID,
    BLECharacteristic::PROPERTY_READ   |
    BLECharacteristic::PROPERTY_NOTIFY
  );

  pService ->start();

  BLEAdvertising *pAdvertising =pServer->getAdvertising();
  pAdvertising->addServiceUUID(pService->getUUID());
  pAdvertising->start();

  Serial.println("Servidor Bluetooth pronto! Aguardando conexões...");
}

void loop(){

  rotacoes_contador++;

  pCharacteristic->setValue((uint8_t*)&rotacoes_contador, sizeof(rotacoes_contador));

  if (deviceConnected) {
    pCharacteristic->notify();
  };

  delay(1000); // Aguarda 1 segundo antes de enviar o próximo valor
}