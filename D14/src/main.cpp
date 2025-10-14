// src/main.cpp

#include <iostream>

#ifdef _WIN32
    #define PLATFORM_NAME "Windows"
#elif __linux__
    #define PLATFORM_NAME "Linux"
#else
    #define PLATFORM_NAME "Autre OS"
#endif

int main() {
    // Affiche un message de salutation
    std::cout << "=======================================" << std::endl;
    std::cout << " Workshop 2025 - Defi Cross-Platform" << std::endl;
    std::cout << " Application executee sur : " << PLATFORM_NAME << std::endl;
    std::cout << " Version : 1.0" << std::endl;
    std::cout << "=======================================" << std::endl;

    // Cette application simule l'execution du code lié aux 23 defis
    // (Par exemple, un appel API, ou le lancement d'une interface graphique)
    return 0;
}