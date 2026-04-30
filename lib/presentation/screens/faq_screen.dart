import 'package:flutter/material.dart';
import '../../shared/constants/app_colors.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryNavy),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "FAQ",
          style: TextStyle(
            color: AppColors.primaryNavy,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Header Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const Text(
                    "Foire",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryNavy,
                      height: 1.1,
                    ),
                  ),
                  const Text(
                    "Aux Questions",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryLime, // Olive green
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Vous souhaitez rejoindre la communauté GbatCar mais vous avez encore des questions ? Consultez les réponses ci-dessous.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF5A6B87),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // FAQ List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  _buildFaqItem("1. Qu'est-ce que GbatCar et à qui s'adresse la solution ?", "GbatCar est une entreprise spécialisée dans le leasing automobile. Nous proposons des solutions de Location Longue Durée (LLD), Location Courte Durée (LCD), Location avec Option d'Achat (LOA) et des partenariats. Nos offres s'adressent aussi bien aux particuliers qu'aux entreprises souhaitant une gestion simplifiée de leur mobilité."),
                  _buildFaqItem("2. Quelles sont les solutions de leasing proposées par GbatCar ?", "Nous proposons plusieurs formules flexibles : la Location Longue Durée (LLD) pour rouler sans se soucier de l'entretien, la Location Courte Durée (LCD) pour des besoins ponctuels, et la Location avec Option d'Achat (LOA) pour devenir propriétaire du véhicule à la fin du contrat."),
                  _buildFaqItem("3. Quelles sont les conditions pour souscrire à un contrat de leasing ?", "Pour les particuliers, il faut fournir une pièce d'identité, un permis de conduire, un justificatif de domicile et un justificatif de revenus. Pour les entreprises, nous demandons le Registre de Commerce, la DFE, les statuts et des relevés bancaires récents."),
                  _buildFaqItem("4. Que comprennent les paiements mensuels ?", "Selon la formule choisie, vos paiements peuvent inclure le coût de location du véhicule, l'assurance tous risques, l'entretien préventif régulier et l'assistance. Vous profitez ainsi d'un véhicule clé en main avec un budget maîtrisé."),
                  _buildFaqItem("5. Dois-je fournir un apport initial ?", "L'apport initial dépend du type de contrat (LOA, LLD) et du véhicule choisi. Nous proposons des conditions flexibles et adaptées à votre profil financier pour faciliter l'accès à votre véhicule."),
                  _buildFaqItem("6. Quelle est la durée d'un contrat de leasing ?", "La durée varie en fonction de vos besoins et de la formule choisie (LCD, LLD ou LOA). Les contrats peuvent aller de quelques jours pour la courte durée, jusqu'à 24, 36 ou 48 mois pour la longue durée et l'option d'achat."),
                  _buildFaqItem("7. Puis-je suivre l'état de mon contrat en ligne ?", "Absolument. L'application GbatCar vous permet de suivre l'historique de vos paiements, l'état de votre contrat, de télécharger vos reçus et de consulter les prochaines échéances d'entretien de votre véhicule."),
                  _buildFaqItem("8. Que se passe-t-il à la fin d'un contrat LOA (Location avec Option d'Achat) ?", "À la fin de votre contrat LOA, si vous avez effectué tous les versements prévus, GbatCar vous transfère officiellement la propriété du véhicule et la carte grise est mise à votre nom."),
                  _buildFaqItem("9. Que se passe-t-il à la fin d'un contrat LLD (Location Longue Durée) ?", "À l'échéance d'un contrat LLD, vous restituez simplement le véhicule à GbatCar. Vous avez alors la possibilité de souscrire à un nouveau contrat pour repartir avec un véhicule récent."),
                  _buildFaqItem("10. Pourquoi choisir GbatCar pour mon leasing automobile ?", "GbatCar offre une flexibilité totale adaptée aux particuliers comme aux entreprises. Avec un accompagnement personnalisé, des démarches simplifiées et des mensualités tout compris, vous maîtrisez votre budget auto sans les contraintes liées à l'achat et à l'entretien."),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Footer Section
            Container(
              width: double.infinity,
              color: const Color(0xFFF8FAFC),
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "GBATCAR",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD1D5DB), // Light grey string
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: Color(0xFFE2E8F0), thickness: 1),
                  const SizedBox(height: 20),
                  
                  const Text(
                    "GBATGROUP \nCocody chateau, Abidjann, Côte d'ivoire",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primaryNavy,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  const Text(
                    "Contacter",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryNavy,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "GBATCAR  Siège\nCocody chateau star 16,Abidjan,\nCôte d'ivoire\n+225 070 245 0202\ncontact@gbatcar.com",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primaryNavy,
                      height: 1.6,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  const Text(
                    "Social",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryNavy,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "LinkedIn",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primaryNavy,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Theme(
        data: ThemeData(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: AppColors.primaryNavy,
          collapsedIconColor: AppColors.primaryNavy,
          title: Text(
            question,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryNavy,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                answer,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
