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
                  _buildFaqItem("1. Qu'est-ce que GbatCar et à qui s'adresse la solution ?", "GbatCar est une plateforme innovante permettant aux chauffeurs de devenir propriétaires de leur véhicule via un modèle de location avec option d'achat (Lease-to-Own). Elle s'adresse aux professionnels du transport souhaitant acquérir un véhicule sans les contraintes d'un crédit classique."),
                  _buildFaqItem("2. Quelles sont les conditions pour rejoindre GbatCar ?", "Pour rejoindre GbatCar, vous devez posséder un permis de conduire valide, avoir une expérience avérée en tant que chauffeur professionnel, fournir un justificatif de domicile et réussir notre évaluation de conduite et notre formation."),
                  _buildFaqItem("3. Dois-je fournir un apport initial important ?", "L'apport initial dépend du type de véhicule choisi. Toutefois, GbatCar s'efforce de proposer des apports abordables et nettement inférieurs à l'achat comptant ou au crédit bancaire standard."),
                  _buildFaqItem("4. Comment fonctionne le contrat GbatCar ?", "Le contrat GbatCar est basé sur des versements réguliers (hebdomadaires ou journaliers) incluant le coût du véhicule, l'assurance, l'entretien et la gestion administrative. À la fin de la période convenue, la propriété du véhicule vous est transférée."),
                  _buildFaqItem("5. Quelle est la durée du contrat ?", "La durée de nos contrats varie généralement entre 24 et 48 mois, en fonction du type de véhicule et des options de paiement sélectionnées."),
                  _buildFaqItem("6. Que comprennent les paiements ?", "Vos paiements fixes couvrent non seulement le remboursement de votre véhicule, mais également l'assurance tous risques, un forfait d'entretien préventif régulier et l'équipement nécessaire à l'activité (géolocalisation, etc.)."),
                  _buildFaqItem("7. Puis-je suivre mes paiements et mon activité en temps réel ?", "Absolument. Votre application GbatCar vous permet de suivre vos revenus, l'historique de vos paiements, l'état de votre contrat, ainsi que les prochaines échéances d'entretien pour votre véhicule."),
                  _buildFaqItem("8. Que se passe-t-il à la fin du contrat ?", "Une fois tous les versements prévus par votre contrat effectués, GbatCar vous transfère officiellement la carte grise à votre nom. Le véhicule vous appartient définitivement."),
                  _buildFaqItem("9. Ai-je des options après être devenu propriétaire ?", "Oui, une fois propriétaire, vous pouvez continuer à bénéficier des avantages de notre écosystème (courses, assurance flotte) ou choisir de revendre votre véhicule pour recommencer un nouveau contrat GbatCar avec un modèle plus récent."),
                  _buildFaqItem("10. Pourquoi choisir GbatCar plutôt qu'une location classique ou un crédit auto ?", "GbatCar vous garantit de devenir propriétaire à terme (contrairement à la location classique) sans exiger les garanties lourdes des banques. Tout est réuni dans une seule mensualité fixe (assurance, entretien), ce qui vous apporte sérénité et pérennité dans votre activité."),
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
                    "GBATCAR HOLDING LTD\n29 Staveley, W4 3HU, London, UK",
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
                    "GBATCAR CIV Siège\nAbatta, cité BCEAO - Abidjan,\nCôte d'ivoire\n+225 07 00 11 00 40\ninfos@gbatcar.com",
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
